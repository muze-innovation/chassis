/// Packages
import 'package:flutter/material.dart';
import 'package:flutter_chassis/flutter_chassis.dart';

/// Local Files
import '../data/data_provider.dart';
import '../repositories/chassis_repository.dart';
import '../utils/readability.dart';
import '../view/view_provider.dart';

class FoodLandingScreen extends StatefulWidget {
  static const routeName = '/food_landing_screen';
  static const screenName = "Food";

  const FoodLandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodLandingScreenState();
  }
}

class _FoodLandingScreenState extends State<FoodLandingScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final IChassisRepository _chassisRepository = ChassisRepository();
  Iterable<Widget> _items = [];
  bool _isLoading = true;
  late Chassis _chassis;

  @override
  void initState() {
    super.initState();
    setupChassis();
  }

  setupChassis() async {
    // init schema validator
    final resolverSpec =
        await Readability.readFrom('assets/resolver_spec.json');
    final viewSpec = await Readability.readFrom('assets/view_spec.json');
    final schemaValidator =
        SchemaValidator(resolverSpec: resolverSpec, viewSpec: viewSpec);

    // init Chassis
    final dataProvider = AppDataProvider();
    final viewProvider = AppViewProvider();
    _chassis = Chassis(
        dataProvider: dataProvider,
        viewProvider: viewProvider,
        schemaValidator: schemaValidator);

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
}
