import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/SupplierLoginScreen.dart';
import 'package:smartagri/modules/supplier/services/Supplier_auth%20_services.dart';

class SupplierSignupScreen extends StatefulWidget {
  const SupplierSignupScreen({super.key});

  @override
  _SupplierSupplierSignupScreenState createState() => _SupplierSupplierSignupScreenState();
}

class _SupplierSupplierSignupScreenState extends State<SupplierSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonenocontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();



  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  XFile? _companyDocument;
  final auth =  SupplierAuthServices();


  // Function to pick image/document
  Future<void> _pickDocument() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _companyDocument = pickedFile;
    });
  }

  bool isLoading = false;



  void signuphandler() async{
 
    try{
      setState(() {
        isLoading = true;
      });

      await auth.registerSupplier(
        name: _namecontroller.text, 
        email: _emailcontroller.text, 
        password: _passwordController.text, 
        phone: _phonenocontroller.text, 
        address: _addresscontroller.text,
        companyLicenseFile: File(_companyDocument!.path));

        Navigator.pop(context);


        setState(() {
        isLoading = false;
      });


      

    }on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message??'somthing went wrong')));
      
    } 
    
    
    
    
    catch(e){
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));


    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: const Text('SIGN UP'),
        backgroundColor: Colors.green,
      ),*/
      body:isLoading ?  const Center(
        child: CircularProgressIndicator(),
      )  : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Company Name Field
              TextFormField(
                controller: _namecontroller,

                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Email Field
              TextFormField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Phone Number Field
              TextFormField(
                controller: _phonenocontroller,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // Phone Number Field
              TextFormField(
                controller: _addresscontroller,
                minLines: 6,
                maxLines: 20,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
             
             
             
              const SizedBox(height: 16.0),

              // Upload Company Document Button
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickDocument,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload Company Document'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  // Display document name after selection
                  _companyDocument != null
                      ? Text(_companyDocument!.name)
                      : const Text(''),
                ],
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      signuphandler();


                     
                    }
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
               RichText(
                      textAlign:TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Color.fromARGB(255, 11, 10, 10)),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SupplierLoginScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
