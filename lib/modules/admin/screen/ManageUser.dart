import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/admin/screen/UserDetails.dart';

class ManageUser extends StatelessWidget {
  const ManageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        backgroundColor: Colors.green.shade600,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Management',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading users'));
                  }
                  final users = snapshot.data?.docs ?? [];
                  if (users.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final name = user['name'] ?? 'N/A';
                      final email = user['email'] ?? 'N/A';
                      final phone = user['phone'] ?? 'N/A';
                      return _buildUserCard(context, name, email, phone);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build user cards
  Widget _buildUserCard(BuildContext context, String name, String email, String phone) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      shadowColor: Colors.greenAccent,
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.green, size: 40),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Email: $email\nPhone: $phone',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            // Handle menu actions
            if (value == 'edit') {
              // Edit action
            } else if (value == 'delete') {
              // Delete action
            }
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
          icon: const Icon(Icons.more_vert, color: Colors.green),
        ),
        onTap: () {
          // Navigate to the UserDetails page when the card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetails(
                name: name,
                email: email,
                phone: phone, 
              ),
            ),
          );
        },
      ),
    );
  }
}
