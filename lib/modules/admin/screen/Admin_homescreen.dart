import 'package:flutter/material.dart';
import 'package:smartagri/modules/admin/screen/ManageFarmer.dart';
import 'package:smartagri/modules/admin/screen/ManageSupplier.dart';
import 'package:smartagri/modules/admin/screen/ManageUser.dart';

class AdminHomescreen extends StatelessWidget {
  AdminHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Agri',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Dancing Script',
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: const Color.fromARGB(234, 17, 140, 17),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            Center(
              child: Column(
                children: const [
                  Text(
                    'Welcome, Admin!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildCard(context, Icons.person, 'Manage Users'),
                  _buildCard(context, Icons.agriculture, 'Manage Farmer'),
                  _buildCard(context, Icons.local_shipping, 'Manage Supplier'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Manage Users') {
          // Navigate to the Manage User Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManageUser()),
          );
        } else if (title == 'Manage Farmer') {
          // Navigate to the Manage Farmer Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManageFarmer()),
          );
        } else if (title == 'Manage Supplier') {
          // Navigate to the Manage Supplier Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManageSupplierScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title tapped')),
          );
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        shadowColor: Colors.greenAccent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.green.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
