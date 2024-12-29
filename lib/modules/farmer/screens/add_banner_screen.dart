import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({super.key, this.type="farmer"});

  final type;

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {
  XFile? _image;
  final _formKey = GlobalKey<FormState>();

  List<String> _farmers = []; // Replace with your actual farmer data

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      // Handle image picker errors (e.g., user canceled, no camera access)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: ${e.toString()}')),
      );
    }
  }

  Future<void> _addBannerToFirebase() async {
    if (_formKey.currentState!.validate() && _image != null) {
      try {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('banners/${Path.basename(_image!.path)}');
        final uploadTask = await storageRef.putFile(File(_image!.path));
        final imageUrl = await uploadTask.ref.getDownloadURL();

        // Add banner data to Firestore
        await FirebaseFirestore.instance.collection('banners').add({
          'imageUrl': imageUrl,
          'type': widget.type,
        });

        // Clear form and image after successful upload
        setState(() {
          _image = null;
         
          _formKey.currentState!.reset();
        });

        // Show success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Banner added successfully!')),
        );
      } catch (e) {
        // Handle errors (e.g., network issues, storage errors)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding banner: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Banner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Image Preview
                _image != null
                    ? Image.file(
                        File(_image!.path),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),

                // Image Upload Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => _getImage(ImageSource.gallery),
                      child: const Text('Select Image'),
                    ),
                    ElevatedButton(
                      onPressed: () => _getImage(ImageSource.camera),
                      child: const Text('Take Photo'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

               

                // Add Banner Button
                ElevatedButton(
                  onPressed: _addBannerToFirebase,
                  child: const Text('Add Banner'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}