import 'package:flutter/material.dart';
import 'package:flutter_example_application/theme/theme.dart';
import 'package:flutter_example_application/screens/screens.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeLandingScreen(),
    OrderLandingScreen(),
    InboxLandingScreen(),
    AccountLandingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectedBottomNavigationBarItemColor,
        unselectedItemColor: unselectedBottomNavigationBarItemColor,
        selectedIconTheme:
            const IconThemeData(color: selectedBottomNavigationBarItemColor),
        unselectedIconTheme:
            const IconThemeData(color: unselectedBottomNavigationBarItemColor),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: defaultBackgroundColor,
            label: HomeLandingScreen.sreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: OrderLandingScreen.sreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: InboxLandingScreen.sreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: AccountLandingScreen.sreenName,
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
