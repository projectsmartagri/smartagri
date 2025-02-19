import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartagri/modules/farmer/screens/FarmerOrderScreen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerDashBoard.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProfileScreen.dart';
import 'package:smartagri/modules/farmer/screens/farmer_home_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  _FarmerHomeScreenState createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePageContent(),
    const FarmerOrderScreen(),
    const FarmerDashboardScreen(),
    const FarmerProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser();
  }

  Future<void> _checkFirstTimeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true; // Default to true if not set

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomePopup();
      });
      await prefs.setBool('isFirstTime', false); // Set flag to false after showing popup
    }
  }

  void _showWelcomePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("hey Farmer! 🎉"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome to Smart Agri, your smart farming companion! 🌱"),
              SizedBox(height: 10),
              Text("• Browse agricultural machinery for rent."),
              Text("• Check out the marketplace to sell and buy farm products."),
              Text("• Rent the equipment you need for your farm."),
              Text("• List your harvest and other agricultural goods in the marketplace."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 245, 247, 245),
              automaticallyImplyLeading: false,
              title: const Text(
                'Smart Agri',
                style: TextStyle(
                  fontFamily: 'Dancing Script',
                  fontSize: 25,
                  color: Color.fromRGBO(4, 75, 4, 0.961),
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                : const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 25),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.production_quantity_limits, color: Colors.blue, size: 30)
                : const Icon(Icons.production_quantity_limits_outlined, color: Colors.grey, size: 25),
            label: 'My Products',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(Icons.person, color: Colors.blue, size: 30)
                : const Icon(Icons.person_outline, color: Colors.grey, size: 25),
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
}
