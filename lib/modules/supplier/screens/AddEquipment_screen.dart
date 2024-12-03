import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/services/supplier_machinery_service.dart';

class AddEquipmentscreen extends StatefulWidget {
  const AddEquipmentscreen({super.key});

  @override
  _AddMachineryPageState createState() => _AddMachineryPageState();
}

class _AddMachineryPageState extends State<AddEquipmentscreen> {
  final _formKey = GlobalKey<FormState>();
  String machineryName = '';
  String description = '';
  double rentalPrice = 0.0;
   int quantity = 0;
  String availability = 'Available';
  XFile? _image;
  bool loading=false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    _image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  // Function to save machinery details
  void _saveMachinery() async{
    if (_formKey.currentState!.validate()) {
      
    setState(() {
      loading=true;
    });
     await SupplierMachineryService().addMachinary(machineryName, description, rentalPrice,availability,quantity as File,File(_image!.path));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Machinery Added Successfully!')),
      );
      // Reset fields after saving
      _formKey.currentState!.reset();
      setState(() {
        loading=false;
        _image = null; // Reset image selection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Add Machinery'),
        
=======
        title: Text('Add Machinery'),
>>>>>>> refs/remotes/origin/main
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()), // Navigate to HomeScreen
            ); // Navigates back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Machinery Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the machinery name';
                  }
                  return null;
                },
                onChanged: (value) {
                  machineryName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) {
                  description = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rental Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the rental price';
                  }
                  return null;
                },
                onChanged: (value) {
                  rentalPrice = double.tryParse(value) ?? 0.0;
                },
              ),
               TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 0;
                },
              ),
              DropdownButtonFormField<String>(
                value: availability,
                decoration: const InputDecoration(labelText: 'Availability'),
                items: <String>['Available', 'Not Available']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    availability = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image == null
                      ? const Center(child: Text('Tap to upload an image'))
                      : Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveMachinery,
                child: const Text('Add Machinery'),
=======
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity, // Full-width button
                child: ElevatedButton(
                  onPressed: _saveMachinery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 71, 177, 74), // Green color for the button
                    minimumSize: Size(double.infinity, 50), // Set height
                  ),
                  child:loading? CircularProgressIndicator()
                  :Text('Add Machinery'),
                ),
>>>>>>> refs/remotes/origin/main
              ),
            ],
          ),
        ),
      ),
    );
  }
}
