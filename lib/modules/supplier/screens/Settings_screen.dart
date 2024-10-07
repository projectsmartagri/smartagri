// lib/modules/supplier/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      ); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Account Settings'),
            onTap: () {
              // Add functionality here
            },
          ),
          ListTile(
            title: Text('Notification Preferences'),
            onTap: () {
              // Add functionality here
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            onTap: () {
              // Add functionality here
            },
          ),
          ListTile(
            title: Text('Language Preferences'),
            onTap: () {
              // Add functionality here
            },
          ),
          ListTile(
            title: Text('Help & Support'),
            onTap: () {
              // Add functionality here
            },
          ),
        ],
      ),
    );
  }
}
