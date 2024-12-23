import 'package:flutter/material.dart';
import 'package:smartagri/modules/choose_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChooseScreen()),
        );
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, const Color.fromARGB(255, 44, 219, 140)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.network(
                  'network/https://freeeway.com/wp-content/uploads/2024/06/Smart-farming-IoT-SIM-1024x461.png', // Replace with your logo path
                  height: 100,
                ),

                SizedBox(height: 20),

                // App Name
                Text(
                  'Smart Agri',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),

                SizedBox(height: 10),

                // Tagline
                Text(
                  'Farm to Fork, fresh everyday',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade900,
                  ),
                ),

                SizedBox(height: 30),

                // Illustration
                Image.asset(
                  'assets/illustration.png', // Replace with your illustration path
                  height: 200,
                ),

                SizedBox(height: 30),

                // Loading Indicator
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for ChooseScreen
