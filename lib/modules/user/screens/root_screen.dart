import 'package:flutter/material.dart';
import 'package:smartagri/modules/user/screens/accountScreen.dart';
import 'package:smartagri/modules/user/screens/homeScreen.dart';
import 'package:smartagri/modules/user/screens/mycartScreen.dart';
import 'package:smartagri/modules/user/screens/user_order_screen.dart';
import 'package:smartagri/modules/user/screens/user_profile_screen.dart';

class UserRootScreen extends StatefulWidget {
  @override
  _UserRootScreenState createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  // List of screens for bottom navigation bar
  final List<Widget> _screens = [
    HomePage(),
    Mycartscreen(),
    OrderScreen(),
    ProfileScreen()
  ];

  int _currentIndex = 0;

  // Method to handle item taps on the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
