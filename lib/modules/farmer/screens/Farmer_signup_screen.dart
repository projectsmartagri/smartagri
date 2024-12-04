import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FarmerSignupScreen extends StatefulWidget {
  const FarmerSignupScreen({super.key});

  @override
  _FarmerSignupScreenState createState() => _FarmerSignupScreenState();
}

class _FarmerSignupScreenState extends State<FarmerSignupScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _image;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> signupHandler() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your Farmer ID!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String fileName = 'farmer_ids/${userCredential.user!.uid}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child(fileName).putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('farmers').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneNoController.text.trim(),
        'location': _locationController.text.trim(),
        'farmerIdUrl': imageUrl,
        'isApproved': false
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup Successful!')),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmer Signup",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Join as a Farmer",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, "Full Name", Icons.person),
                    const SizedBox(height: 16.0),
                    _buildTextField(_emailController, "Email", Icons.email, isEmail: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                        _passwordController, "Password", Icons.lock, isPassword: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                        _confirmPasswordController, "Confirm Password", Icons.lock, isPassword: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(
                        _phoneNoController, "Phone Number", Icons.phone, isPhone: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(_locationController, "Location", Icons.location_on),
                    const SizedBox(height: 16.0),
                    Row(children: [
                      Expanded(child: _buildImageUploadSection(),)
                    ],),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: signupHandler,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green.shade700,
                        ),
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool isPassword = false, bool isEmail = false, bool isPhone = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green.shade700),
        ),
      ),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (isPhone && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildImageUploadSection() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _image!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text('No image selected'),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Upload Farmer ID',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
