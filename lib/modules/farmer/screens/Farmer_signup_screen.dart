import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _profileImage; // Profile photo file
  File? _farmerIdImage; // Farmer ID file
  bool isLoading = false;

  Future<void> _pickImage(bool isProfileImage) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfileImage) {
          _profileImage = File(pickedFile.path);
        } else {
          _farmerIdImage = File(pickedFile.path);
        }
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

    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your profile photo!')),
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

      // Upload profile photo
      String profileImageUrl = await _uploadFile(_profileImage!, 'profile_photos/${userCredential.user!.uid}.jpg');

      // Upload farmer ID if available
      String farmerIdUrl = '';
      if (_farmerIdImage != null) {
        farmerIdUrl = await _uploadFile(_farmerIdImage!, 'farmer_ids/${userCredential.user!.uid}.jpg');
      }

      // Save to Firestore
      await FirebaseFirestore.instance.collection('farmers').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneNoController.text.trim(),
        'location': _locationController.text.trim(),
        'profileImageUrl': profileImageUrl,
        'farmerIdUrl': farmerIdUrl,
        'isApproved': false,
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

  Future<String> _uploadFile(File file, String path) async {
    UploadTask uploadTask = FirebaseStorage.instance.ref().child(path).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
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
                    _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(_confirmPasswordController, "Confirm Password", Icons.lock, isPassword: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(_phoneNoController, "Phone Number", Icons.phone, isPhone: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(_locationController, "Location", Icons.location_on),
                    const SizedBox(height: 16.0),
                    const Text("Profile Photo"),
                    _buildImageUploadSection(isProfileImage: true, image: _profileImage),
                    const SizedBox(height: 16.0),
                    const Text("Farmer ID (Adhaar Id)"),
                    _buildImageUploadSection(isProfileImage: false, image: _farmerIdImage),
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

  Widget _buildImageUploadSection({required bool isProfileImage, File? image}) {
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
            image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text('No image selected'),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _pickImage(isProfileImage),
              icon: const Icon(Icons.image),
              label: Text(isProfileImage ? 'Upload Profile Photo' : 'Upload Farmer ID'),
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
