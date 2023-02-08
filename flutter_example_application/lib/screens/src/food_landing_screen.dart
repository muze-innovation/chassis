/// Foundation
import 'package:flutter/material.dart';

/// Internal
import 'package:data_provider/core.dart';
import 'package:view_provider/core.dart';
import 'package:view_provider/action/action.dart';
import 'package:flutter_example_application/repository/repository.dart';
import 'package:chassis/validator/schema_validator.dart';
import 'package:flutter_example_application/action/action.dart';

/// Chassis
import 'package:chassis/core.dart';

class FoodLandingScreen extends StatefulWidget {
  static const routeName = '/food_landing_screen';
  static const screenName = "Food";

  const FoodLandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodLandingScreenState();
  }
}

class _FoodLandingScreenState extends State<FoodLandingScreen>
    implements IAction {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final IChassisRepository _chassisRepository = ChassisRepository();
  Iterable<Widget> _items = [];
  bool _isLoading = true;
  late Chassis _chassis;

  @override
  void initState() {
    super.initState();

    // setup chassis
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dataProvider = AppDataProvider();
      final viewProvider = AppViewProvider(delegate: _FoodLandingScreenState());
      final schemaValidator = await SchemaValidator.create();
      _chassis = Chassis(
          dataProvider: dataProvider,
          viewProvider: viewProvider,
          schemaValidator: schemaValidator);
    });

    // call API to load data
    loadData();
  }

  Future loadData() async {
    return _chassisRepository.getData().then((items) => setData(items));
  }

  void setData(Iterable<ChassisItem> items) {
    setState(() {
      _isLoading = false;
      _items = _chassis.getViews(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(FoodLandingScreen.screenName),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                key: _refreshIndicatorKey,
                strokeWidth: 4.0,
                onRefresh: () async {
                  return loadData();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _items.elementAt(index);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 8,
                      color: Colors.transparent,
                    );
                  },
                ),
              ));
  }

  @override
  void dispose() {
    _chassis.dispose();
    super.dispose();
  }

  @override
  void onAction(BuildContext context, Map<String, dynamic> config,
      Map<String, dynamic>? data) {
    print('Food screen on action: $config');
    ActionManager manager = ActionManager.fromJson(config);
    manager.execute(context, data);
  }
}
