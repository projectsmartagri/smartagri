import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierprofileScreen extends StatelessWidget {
  const SupplierprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context);
             Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
                      ); // Navigate back when pressed
          },
        ),
        title: const Text(
          'Profile', // Title of the screen
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
     
    );
  }
}
