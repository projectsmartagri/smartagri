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
            color: Color.fromRGBO(4, 75, 4, 0.961),
            fontFamily: 'Dancing Script',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(234, 32, 203, 32),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: const [
                  Text(
                    'Welcome, Admin!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
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
                  _buildCard(context, Icons.person, 'Manage Farmer'),
                  _buildCard(context, Icons.person, 'Manage Supplier'),
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
        } 
        else if (title == 'Manage Farmer') {
          // Navigate to the Manage User Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManageFarmer()),
          );
        } 

         else if (title == 'Manage Supplier') {
          // Navigate to the Manage User Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ManageSupplierScreen()),
          );
        } 

        
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title tapped')),
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
