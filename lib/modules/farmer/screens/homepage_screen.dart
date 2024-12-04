import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/FarmerOrderScreen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProductScreen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProfileScreen.dart';
import 'package:smartagri/modules/farmer/screens/farmer_home_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  _FarmerHomeScreenState createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePageContent(),
    FarmerOrderScreen(),
    FarmerProductScreen(),
    FarmerProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchPressed() {
    print('Search icon pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text(
                'Smart Agri',
                style: TextStyle(
                  fontFamily: 'Dancing Script',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearchPressed,
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerNotificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(Icons.home, color: Colors.blue, size: 30)
                : const Icon(Icons.home_outlined, color: Colors.grey, size: 25),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.shopping_cart, color: Colors.blue, size: 30)
                : const Icon(Icons.shopping_cart_outlined,
                    color: Colors.grey, size: 25),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.production_quantity_limits,
                    color: Colors.blue, size: 30)
                : const Icon(Icons.production_quantity_limits_outlined,
                    color: Colors.grey, size: 25),
            label: 'My Products',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(Icons.person, color: Colors.blue, size: 30)
                : const Icon(Icons.person_outline,
                    color: Colors.grey, size: 25),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  FarmerNotificationScreen() {}
}

