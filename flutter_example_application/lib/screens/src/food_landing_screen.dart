import 'package:flutter/material.dart';
import 'package:chassis/chassis.dart';
import 'package:flutter_example_application/repository/repository.dart';

class FoodLandingScreen extends StatefulWidget {
  static const routeName = '/food_landing_screen';
  static const sreenName = "Food";

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
  List<Widget> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    return _chassisRepository.getData().then((data) => setData(data));
  }

  void setData(Map<String, dynamic> data) {
    setState(() {
      _isLoading = false;

      // ## Call chassis here
      //
      // Chassis.setDataProvider(dataProvider);
      // Chassis.setViewProvider(viewProvider);
      //
      _items = Chassis.getView(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(FoodLandingScreen.sreenName),
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
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _items[index];
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
}
