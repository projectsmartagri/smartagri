import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class EquipmentDetailsscreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rentRate;

  const EquipmentDetailsscreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rentRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()), // Navigate to HomeScreen
            );// Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rent Rate: $rentRate',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            // Add any additional details about the equipment here
          ],
        ),
      ),
    );
  }
}