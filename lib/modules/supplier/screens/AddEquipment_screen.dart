import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/services/supplier_machinery_service.dart';

class AddEquipmentscreen extends StatefulWidget {
  @override
  _AddMachineryPageState createState() => _AddMachineryPageState();
}

class _AddMachineryPageState extends State<AddEquipmentscreen> {
  final _formKey = GlobalKey<FormState>();
  String machineryName = '';
  String description = '';
  double rentalPrice = 0.0;
  String availability = 'Available';
  XFile? _image;
  bool loading=false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  // Function to save machinery details
  void _saveMachinery() async{
    if (_formKey.currentState!.validate()) {
      
    setState(() {
      loading=true;
    });
     await SupplierMachineryService().addMachinary(machineryName, description, rentalPrice,availability,File(_image!.path));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Machinery Added Successfully!')),
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
        title: Text('Add Machinery'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupplierHomeScreen()), // Navigate to HomeScreen
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
                decoration: InputDecoration(labelText: 'Machinery Name'),
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
                decoration: InputDecoration(labelText: 'Description'),
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
                decoration: InputDecoration(labelText: 'Rental Price'),
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
              DropdownButtonFormField<String>(
                value: availability,
                decoration: InputDecoration(labelText: 'Availability'),
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
              SizedBox(height: 16),
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
                      ? Center(child: Text('Tap to upload an image'))
                      : Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
