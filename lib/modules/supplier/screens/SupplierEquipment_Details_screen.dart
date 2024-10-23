import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierEquipmentDetailsScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rentRate;
  final String description;
  final int quantity;

  const SupplierEquipmentDetailsScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rentRate,
    required this.description,
    required this.quantity, required List farmersOrders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data of farmers who ordered this equipment
    final List<Map<String, String>> farmersOrders = [
      {
        'farmerName': 'Farmer John',
        'bookingDate': '2024-10-01',
        'dueDate': '2024-10-07',
        'returnDate': '2024-10-06',
      },
      {
        'farmerName': 'Farmer Alice',
        'bookingDate': '2024-10-02',
        'dueDate': '2024-10-09',
        'returnDate': '2024-10-08',
      },
      {
        'farmerName': 'Farmer Bob',
        'bookingDate': '2024-10-05',
        'dueDate': '2024-10-12',
        'returnDate': '', // Not returned yet
      },
      {
        'farmerName': 'Farmer Charlie',
        'bookingDate': '2024-10-03',
        'dueDate': '2024-10-10',
        'returnDate': '', // Not returned yet
      },
    ];

    // Identify farmers who have not returned the equipment
    final List<Map<String, String>> notReturnedFarmers = farmersOrders
        .where((order) => order['returnDate'] == '') // Check for empty return date
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to the home screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center-align the equipment image
            Center(
              child: Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),

            // Equipment name
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Rent rate
            Text(
              'Rent Rate: $rentRate/day',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),

            // Equipment description
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Quantity
            Text(
              'Available Quantity: $quantity',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),

            // Farmers who ordered the equipment
            const Text(
              'Farmers Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true, // Ensures the ListView works with SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Prevents scrolling conflict
              itemCount: farmersOrders.length,
              itemBuilder: (context, index) {
                final order = farmersOrders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('Farmer: ${order['farmerName']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Date: ${order['bookingDate']}'),
                        Text('Due Date: ${order['dueDate']}'),
                        Text(
                          'Return Date: ${order['returnDate']}', // Display return date
                          style: order['returnDate'] == ''
                              ? const TextStyle(color: Colors.red) // Non-returned date in red
                              : const TextStyle(color: Colors.green), // Return date in green
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
