import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/FarmerEditProfile.dart';
import 'package:smartagri/modules/farmer/screens/FarmerSettingScreen.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerEditProfile(name: '', email: '', phone: '', address: '',)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerSettingsScreen()),
                );
              },
            ),
            const Spacer(),  

            // Log Out option at the bottom
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Handle Log Out action
                Navigator.pop(context); // Close the drawer
                // Implement your logout functionality here
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Name
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: const Text(
                'Farmer | Organic Produce',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Farmer Details Section
            const Text(
              'Personal Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.email, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  '+1 234 567 8901',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  '123 Farm Lane, Rural City, State',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Farm Information Section
            const Text(
              'Farm Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.local_atm, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  'Farm Size: 50 Acres',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.agriculture, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  'Crops: Wheat, Corn, Soybean',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.water, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  'Water Source: Well Water',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



