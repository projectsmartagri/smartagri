import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smartagri/modules/supplier/services/Supplier_auth%20_services.dart';

class SupplierSignupScreen extends StatefulWidget {
  const SupplierSignupScreen({Key? key}) : super(key: key);

  @override
  _SupplierSignupScreenState createState() => _SupplierSignupScreenState();
}

class _SupplierSignupScreenState extends State<SupplierSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;

  XFile? _companyLogo;
  XFile? _companyDocument;
  String? _companyLogoUrl;

  final auth = SupplierAuthServices();

  // Pick Document
  Future<void> _pickDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _companyDocument = pickedFile;
    });
  }

  // Pick Company Logo
  Future<void> _pickCompanyLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _companyLogo = pickedFile;
    });
  }

  // Upload Logo to Firebase
  Future<String?> _uploadCompanyLogo() async {
    if (_companyLogo == null) return null;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('company_logos/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await storageRef.putFile(File(_companyLogo!.path));
    return await storageRef.getDownloadURL();
  }

  // Signup Handler
  Future<void> signupHandler() async {
    try {

      setState(() {
        isLoading = true;
      });
      
      if (_companyLogo != null) {
        _companyLogoUrl = await _uploadCompanyLogo();
      }

      

      await auth.registerSupplier(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneNoController.text,
        address: _addressController.text,
        companyLicenseFile: File(_companyDocument!.path),
        companyLogoUrl: _companyLogoUrl!,
      );

      Navigator.pop(context);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Form Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          const Text(
                            'Supplier Sign Up',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Company Name',
                              prefixIcon: const Icon(Icons.business),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter company name' : null,
                          ),
                          const SizedBox(height: 16),
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Phone Number Field
                          TextFormField(
                            controller: _phoneNoController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter your phone number' : null,
                          ),
                          const SizedBox(height: 16),
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Confirm Password Field
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Address Field
                          TextFormField(
                            controller: _addressController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              prefixIcon: const Icon(Icons.location_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter your address' : null,
                          ),
                          const SizedBox(height: 16),
                          // Company Logo
                          Wrap(
                            children: [
                              _companyLogo == null
                                  ? const Text('No Logo Selected')
                                  : Image.file(
                                      File(_companyLogo!.path),
                                      
                                      
                                      fit: BoxFit.cover,
                                    ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: _pickCompanyLogo,
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 50),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.green
                                ),
                                icon: const Icon(Icons.image),
                                label: const Text('Upload Logo'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Company License Document
                          Wrap(
                            children: [
                               _companyDocument == null
                                  ? SizedBox()
                                  : Image.file(
                                      File(_companyDocument!.path),
                                      
                                      fit: BoxFit.cover,
                                    ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: _pickDocument,
                                
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 50),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.green
                                ),
                                icon: const Icon(Icons.file_present),
                                label: const Text('Upload Document'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Sign Up Button
                          isLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        signupHandler();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(fontSize: 18,color: Colors.white),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



