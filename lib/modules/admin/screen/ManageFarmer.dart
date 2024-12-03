import 'package:flutter/material.dart';
import 'package:smartagri/modules/admin/screen/FarmerDetails.dart';

class ManageFarmer extends StatelessWidget {
  const ManageFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Farmers'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Farmer Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildFarmerCard(
                    context,
                    'John Doe',
                    'johndoe@gmail.com',
                    '123-456-7890',
                  ),
                  _buildFarmerCard(
                    context,
                    'Jane Smith',
                    'janesmith@gmail.com',
                    '987-654-3210',
                  ),
                  _buildFarmerCard(
                    context,
                    'Peter Parker',
                    'peterparker@gmail.com',
                    '456-789-1234',
                  ),
                  // Add more farmers as needed
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a page to add new farmers
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add Farmer tapped')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  minimumSize: const Size(double.infinity, 50), // Button height
                ),
                child: const Text('Add New Farmer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerCard(
      BuildContext context, String name, String email, String phone) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerDetails(
              name: name,
              email: email,
              phone: phone, location: '', imageUrl: '', certificateImageUrl: '',
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.person, color: Colors.green),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Email: $email\nPhone: $phone'),
          trailing: PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle menu actions
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}

