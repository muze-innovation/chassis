import 'package:flutter/material.dart';
import 'package:chassis/chassis.dart';
import 'package:flutter_example_application/repository/repository.dart';

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
  final List<Widget> _items = [];
  List<Widget> _originalItems = [];
  bool _isLoading = true;

  int perPage = 2;
  int present = 0;

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
      // _items = Chassis.getView(data);
      _originalItems = Chassis.getView(data);
      var end = present + perPage > _originalItems.length
          ? _originalItems.length
          : present + perPage;
      _items.addAll(_originalItems.getRange(present, end));
      present += perPage;
    });
  }

  Future refreshData() async {
    return _chassisRepository.getData().then((data) => {
          setState(() {
            _isLoading = false;
            // _items = Chassis.getView(data);
            _originalItems = Chassis.getView(data);
            // _items.addAll(_originalItems.getRange(present, present + perPage));
            var end = present > _originalItems.length
                ? _originalItems.length
                : present;
            _items.replaceRange(0, present, _originalItems.getRange(0, end));
          })
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
                  return refreshData();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  // itemCount: _items.length,
                  itemCount: (present < _originalItems.length)
                      ? _items.length + 1
                      : _items.length,
                  itemBuilder: (context, index) {
                    // return _items[index];
                    return (index == _items.length)
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              child: const Text("Load More"),
                              onPressed: () {
                                setState(() {
                                  if ((present + perPage) >
                                      _originalItems.length) {
                                    _items.addAll(_originalItems.getRange(
                                        present, _originalItems.length));
                                  } else {
                                    _items.addAll(_originalItems.getRange(
                                        present, present + perPage));
                                  }
                                  refreshData();
                                  present += perPage;
                                });
                              },
                            ),
                          )
                        : _items[index];
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
