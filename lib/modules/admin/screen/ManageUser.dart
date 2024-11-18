import 'package:flutter/material.dart';

class ManageUser extends StatelessWidget {
  const ManageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildUserCard('Alice Johnson', 'alice.j@gmail.com', 'Admin'),
                  _buildUserCard('Bob Smith', 'bob.smith@gmail.com', 'Supplier'),
                  _buildUserCard('Charlie Brown', 'charlie.b@gmail.com', 'Farmer'),
                  // Add more users as needed
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a page to add a new user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add User tapped')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  minimumSize: const Size(double.infinity, 50), // Button height
                ),
                child: const Text('Add New User'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(String name, String email, String role) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.green),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Email: $email\nRole: $role'),
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
    );
  }
}
