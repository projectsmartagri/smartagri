import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierBookingdetailsScreen extends StatelessWidget {
  const SupplierBookingdetailsScreen({super.key});

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
          'Booking Details', // Title of the screen
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
     
    );
  }
}
