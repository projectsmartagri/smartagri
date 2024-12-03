import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SupplierEditProfileScreen extends StatefulWidget {
  const SupplierEditProfileScreen({super.key});

  @override
  _SupplierEditProfileScreenState createState() =>
      _SupplierEditProfileScreenState();
}

class _SupplierEditProfileScreenState extends State<SupplierEditProfileScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _backgroundImage;
  String? _licenseImage;
  String? _backgroundImageUrl;  // To store the URL of the background image
  String? _licenseImageUrl;     // To store the URL of the license image

  @override
  void initState() {
    super.initState();
    fetchSupplierData(); // Fetch supplier data on initialization
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Fetch supplier data from Firestore
  Future<void> fetchSupplierData() async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot supplierDoc = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(id)
          .get();

      if (supplierDoc.exists) {
        final data = supplierDoc.data() as Map<String, dynamic>;

        setState(() {
          _companyNameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _addressController.text = data['address'] ?? '';

          // Fetching the URL for background image (logo)
          _backgroundImageUrl = data['logo'];

          // Fetching the URL for company license image
          _licenseImageUrl = data['companyLicenseUrl'];
        });
      }
    } catch (e) {
      print('Error fetching supplier data: $e');
    }
  }

  // Method to pick an image from the gallery and upload it to Firebase Storage
  Future<void> _pickImage(bool isLicense) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (isLicense) {
          // Replace the previous license image with the new one
          _licenseImage = pickedImage.path;
        } else {
          // Replace the previous logo image with the new one
          _backgroundImage = File(pickedImage.path);
        }
      });

      // Upload the image to Firebase Storage and get the URL
      String imageUrl = await uploadImageToStorage(File(pickedImage.path), isLicense);
      
      // Update Firestore with the new image URL
      await updateSupplierData(imageUrl, isLicense);
    }
  }

  // Function to upload image to Firebase Storage and return the download URL
  Future<String> uploadImageToStorage(File imageFile, bool isLicense) async {
    try {
      // Generate a unique name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('supplier_images/$fileName.jpg');
      
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(imageFile);
      
      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;
      
      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Update Firestore with the new image URL
  Future<void> updateSupplierData(String imageUrl, bool isLicense) async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final supplierRef = FirebaseFirestore.instance.collection('suppliers').doc(id);
      
      if (isLicense) {
        // Update the company license image
        await supplierRef.update({'companyLicenseUrl': imageUrl});
      } else {
        // Update the logo image
        await supplierRef.update({'logo': imageUrl});
      }
    } catch (e) {
      print('Error updating supplier data: $e');
    }
  }

  // Method to save the edited company details
  Future<void> saveEditedData() async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final supplierRef = FirebaseFirestore.instance.collection('suppliers').doc(id);

      // Update the company details in Firestore
      await supplierRef.update({
        'name': _companyNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      });

      // After updating Firestore, fetch and show the updated data
      fetchSupplierData();

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

    } catch (e) {
      print('Error saving edited data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Displaying the background image using Image.network for URL from Firebase
            ClipOval(
              child: _backgroundImage != null
                  ? Image.file(
                      _backgroundImage!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : _backgroundImageUrl != null
                      ? Image.network(
                          _backgroundImageUrl!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _pickImage(false),
              child: const Text('Change Logo'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Company License',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _licenseImage != null
                ? Image.file(
                    File(_licenseImage!),
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : _licenseImageUrl != null
                    ? Image.network(
                        _licenseImageUrl!,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: const Color.fromARGB(192, 194, 197, 195),
                        child: const Icon(
                          Icons.add_photo_alternate,
                          color: Color.fromARGB(255, 249, 247, 247),
                          size: 50,
                        ),
                      ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _pickImage(true),
              child: const Text('Change License Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveEditedData, // Save the edited data
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
