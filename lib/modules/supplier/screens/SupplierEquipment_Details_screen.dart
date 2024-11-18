import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/services/supplier_machinery_service.dart';
import 'package:smartagri/utils/helper.dart';

class SupplierEquipmentDetailsScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rentRate;
  final String description;
  final int quantity;
  final String id;

  const SupplierEquipmentDetailsScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rentRate,
    required this.description,
    required this.quantity, required List farmersOrders,
    required this.id,

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

    void Machinarydel()async{
      try{

        await SupplierMachineryService().machinarydel(id);

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('s')));


      }
      catch(e){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('f')));

      }



    }

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
                          builder: (context) => EditEquipmentScreen(id: id,initialName: name, initialImageUrl: imageUrl, initialRentRate: rentRate, initialDescription:description, initialQuantity: quantity,),
                        ),
                      );
              
            },
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Machinarydel();
              
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
              'Quantity: $quantity',
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
  String initialImageUrl;
  final String initialRentRate;
  final String initialDescription;
  final int initialQuantity;
  String id;

  EditEquipmentScreen({
    Key? key,
    required this.initialName,
    required this.initialImageUrl,
    required this.initialRentRate,
    required this.initialDescription,
    required this.initialQuantity,
    required this.id,
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


  bool isloading = false;

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

    SupplierMachineryService().machinaryedit(
      name: _nameController.text , imageUrl: widget.initialImageUrl, rentRate: _rentRateController.text, description: _descriptionController.text, quantity: _quantityController.text , id: widget.id);
    
    Navigator.pop(context);
  }

    Future<void> _pickImage() async {

      setState(() {
        isloading = true;
      });
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
     widget.initialImageUrl = await  uploadfile(name: 'machine', uid: widget.id , file: File(image.path));
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Equipment'),
      ),
      body: isloading ? Center(
        child: CircularProgressIndicator(),
      )  : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Center(
                child: ElevatedButton(
                  onPressed: () {
                    _pickImage();
                    
                  },
                  child: const Text('Edit image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 227, 221), // Set the button background to green
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              Image.network(widget.initialImageUrl),
               
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Equipment Name'),
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
                decoration: const InputDecoration(labelText: 'Quantity'),
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
