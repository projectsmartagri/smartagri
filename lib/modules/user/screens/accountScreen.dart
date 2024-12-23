import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _paymentMethodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Example pre-filled data
    _nameController.text = 'Jane Doe';
    _addressController.text = '123 Elm St, Springfield, IL';
    _paymentMethodController.text = 'Visa ending in 1234';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumer Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.example.com/consumer_profile_image.jpg'), // Replace with consumer's profile image URL
              ),
              const SizedBox(height: 20),
              // Consumer Details Section
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Shipping Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _paymentMethodController,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Save Changes Button
              ElevatedButton(
                onPressed: () {
                  // Save updated consumer details
                  print('Updated Full Name: ${_nameController.text}');
                  print('Updated Address: ${_addressController.text}');
                  print('Updated Payment Method: ${_paymentMethodController.text}');
                },
                child: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              // Log Out Button
              ElevatedButton(
                onPressed: () {
                  // Handle logout logic here
                  print('Consumer logged out');
                },
                child: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
