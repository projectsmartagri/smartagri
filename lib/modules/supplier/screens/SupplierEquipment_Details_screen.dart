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
        actions: [
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEquipmentScreen(initialName: '', initialImageUrl: '', initialRentRate: '', initialDescription: '', initialQuantity: quantity,),
                        ),
                      );
              
            },
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Handle delete action (you can implement your own logic here)
              print('Delete button clicked');
            },
          ),
        ],
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
              style: const TextStyle(fontSize: 18, ),
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




//edit details
class EditEquipmentScreen extends StatefulWidget {
  final String initialName;
  final String initialImageUrl;
  final String initialRentRate;
  final String initialDescription;
  final int initialQuantity;

  const EditEquipmentScreen({
    Key? key,
    required this.initialName,
    required this.initialImageUrl,
    required this.initialRentRate,
    required this.initialDescription,
    required this.initialQuantity,
  }) : super(key: key);

  @override
  _EditEquipmentScreenState createState() => _EditEquipmentScreenState();
}

class _EditEquipmentScreenState extends State<EditEquipmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _rentRateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current data
    _nameController.text = widget.initialName;
    _imageUrlController.text = widget.initialImageUrl;
    _rentRateController.text = widget.initialRentRate;
    _descriptionController.text = widget.initialDescription;
    _quantityController.text = widget.initialQuantity.toString();
  }

  void _saveChanges() {
    // Implement save functionality (e.g., update data in a database or send to an API)
    print("Equipment details updated");
    // For now, simply print the updated values
    print("Name: ${_nameController.text}");
    print("Image URL: ${_imageUrlController.text}");
    print("Rent Rate: ${_rentRateController.text}");
    print("Description: ${_descriptionController.text}");
    print("Quantity: ${_quantityController.text}");
    
    // After saving, pop the screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Equipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Equipment Name'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: _rentRateController,
                decoration: const InputDecoration(labelText: 'Rent Rate'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Available Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20), // Add spacing before the Save button
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set the button background to green
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
