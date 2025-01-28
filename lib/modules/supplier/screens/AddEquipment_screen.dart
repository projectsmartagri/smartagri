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
 int quantity = 0;
  String availability = 'Available';
  XFile? _image;
  bool loading = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _saveMachinery() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image!')),
        );
        return;
      }

      setState(() {
        loading = true;
      });

      await SupplierMachineryService().addMachinary(
        machineryName,
        description,
        rentalPrice,
        availability,
        quantity,
        File(_image!.path),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Machinery Added Successfully!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        loading = false;
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('Add Machinery',style: TextStyle(color: Colors.white,),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Machinery Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Machinery Name',
                  labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4CAF50)),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the machinery name'
                    : null,
                onChanged: (value) => machineryName = value,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4CAF50)),
                  ),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
                onChanged: (value) => description = value,
              ),
              const SizedBox(height: 16),

              // Rental Price Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Rental Price',
                  labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4CAF50)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the rental price'
                    : null,
                onChanged: (value) =>
                    rentalPrice = double.tryParse(value) ?? 0.0,
              ),
              const SizedBox(height: 16),

              // Quantity Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4CAF50)),
                  ),
                ),
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
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 16),

              // Availability Dropdown
              DropdownButtonFormField<String>(
                value: availability,
                decoration: InputDecoration(
                  labelText: 'Availability',
                  labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: <String>['Available', 'Not Available']
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() => availability = newValue!);
                },
              ),
              const SizedBox(height: 16),

              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F8E9),
                    border: Border.all(color: const Color(0xFF4CAF50)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? const Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Color(0xFF8D6E63),
                            size: 50,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveMachinery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Add Machinery',style: TextStyle(color: Colors.white,),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
