import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/SupplierEditProfile_Screen.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
 

class SupplierProfileScreen extends StatelessWidget {
  const SupplierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/company_logo.png'), // Placeholder image
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Company Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Supplier Company ABC', // Replace with actual company name
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),
            const Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'supplier@example.com', // Replace with actual email
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),
            const Text(
              'Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '+123 456 7890', // Replace with actual phone number
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),
            const Text(
              'Company License',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'License XYZ12345', // Replace with actual license
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SupplierEditProfileScreen()), // Navigate to Edit Profile screen
                  );
                },
                child: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
