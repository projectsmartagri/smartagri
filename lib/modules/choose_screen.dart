import 'package:flutter/material.dart';
import 'package:smartagri/modules/admin/screen/AdminLoginScreen.dart';
import 'package:smartagri/modules/farmer/screens/login_screen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierLoginScreen.dart';
import 'package:smartagri/modules/user/screens/User_loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Agri',
      home: ChooseScreen(),
    );
  }
}

class ChooseScreen extends StatelessWidget {
  ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Smart Agri',
          style: TextStyle(
            color: Color(0xFF2E7D32), // Dark green
            fontFamily: 'Dancing Script',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 202, 223, 202), // Light green
      ),
      body: Container(
        color: Color(0xFFE8F5E9), // Soft light green background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ModuleButton(
                    moduleName: 'Farmer',
                    icon: Icons.agriculture,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                  ModuleButton(
                    moduleName: 'User',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserLoginscreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ModuleButton(
                    moduleName: 'Supplier',
                    icon: Icons.local_shipping,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupplierLoginScreen(),
                        ),
                      );
                    },
                  ),
                  ModuleButton(
                    moduleName: 'Admin',
                    icon: Icons.admin_panel_settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Adminloginscreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleButton extends StatefulWidget {
  final String moduleName;
  final IconData icon;
  final VoidCallback onTap;

  const ModuleButton({
    required this.moduleName,
    required this.icon,
    required this.onTap,
  });

  @override
  _ModuleButtonState createState() => _ModuleButtonState();
}

class _ModuleButtonState extends State<ModuleButton> {
  bool _isClicked = false;

  void _handleTap() {
    setState(() {
      _isClicked = true;
    });

    // Delay to show the clicked effect
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _isClicked = false;
      });
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _handleTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          color: _isClicked ? Color.fromARGB(255, 207, 222, 189) : Colors.white, // Highlighted background when clicked
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 48,
                  color: _isClicked ? Colors.white : Color.fromARGB(255, 44, 103, 47), // Icon color changes when clicked
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.moduleName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isClicked ? Colors.white : Colors.black87, // Text color changes when clicked
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
