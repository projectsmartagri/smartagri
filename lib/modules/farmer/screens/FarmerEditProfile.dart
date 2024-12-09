import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class FarmerEditProfile extends StatefulWidget {
  final String farmerId; // Farmer's document ID in Firestore

  const FarmerEditProfile({super.key, required this.farmerId});

  @override
  _FarmerEditProfileState createState() => _FarmerEditProfileState();
}

class _FarmerEditProfileState extends State<FarmerEditProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  String? profileImageUrl;
  String? farmerIdUrl;

  bool isLoading = true;
  bool isUpdatingImage = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(widget.farmerId)
          .get();

      final data = doc.data();
      if (data != null) {
        nameController = TextEditingController(text: data['name'] ?? '');
        emailController = TextEditingController(text: data['email'] ?? '');
        phoneController = TextEditingController(text: data['phone'] ?? '');
        locationController = TextEditingController(text: data['location'] ?? '');
        profileImageUrl = data['profileImageUrl'];
        farmerIdUrl = data['farmerIdUrl'];
      } else {
        throw Exception("Farmer data not found!");
      }
    } catch (e) {
      nameController = TextEditingController();
      emailController = TextEditingController();
      phoneController = TextEditingController();
      locationController = TextEditingController();
      profileImageUrl = null;
      farmerIdUrl = null;
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isUpdatingImage = true;
      });

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos/${widget.farmerId}.jpg');

      try {
        // Upload image to Firebase Storage
        final uploadTask = await storageRef.putFile(File(pickedFile.path));
        final newProfileUrl = await uploadTask.ref.getDownloadURL();

        // Update Firestore with new profile photo URL
        await FirebaseFirestore.instance
            .collection('farmers')
            .doc(widget.farmerId)
            .update({'profileImageUrl': newProfileUrl});

        setState(() {
          profileImageUrl = newProfileUrl;
          isUpdatingImage = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile photo updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() {
          isUpdatingImage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    final updatedName = nameController.text.trim();
    final updatedEmail = emailController.text.trim();
    final updatedPhone = phoneController.text.trim();
    final updatedLocation = locationController.text.trim();

    if (updatedName.isEmpty ||
        updatedEmail.isEmpty ||
        updatedPhone.isEmpty ||
        updatedLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('farmers')
          .doc(widget.farmerId)
          .update({
        'name': updatedName,
        'email': updatedEmail,
        'phone': updatedPhone,
        'location': updatedLocation,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Profile Picture with Update Option
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl!)
                              : null,
                          child: profileImageUrl == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickAndUploadImage,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: isUpdatingImage
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.camera_alt, color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Phone Field
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Location Field
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Save Changes Button
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
