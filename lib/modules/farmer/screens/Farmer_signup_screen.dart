import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:smartagri/modules/supplier/services/Supplier_auth%20_services.dart';

class FarmerSignupScreen extends StatefulWidget {
  const FarmerSignupScreen({super.key});

  @override
  _FarmerSignupScreenState createState() => _FarmerSignupScreenState();
}

class _FarmerSignupScreenState extends State<FarmerSignupScreen> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonenocontroller = TextEditingController();










  File? _image;
  bool isLoading=false;
   final auth =  SupplierAuthServices();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
    void signuphandler() async{
 
    try{
      setState(() {
        isLoading = true;
      });

      // await auth.registerSupplier(
      //   name: _namecontroller.text, 
      //   email: _emailcontroller.text, 
      //   password: _passwordController.text, 
      //   phone: _phonenocontroller.text, 
      //   address: '',
      //   companyLicenseFile: File(_image!.path));

      //   Navigator.pop(context);


      //   setState(() {
      //   isLoading = false;
      // });


      

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
      appBar: AppBar(
        title: const Text(
          "SIGN UP",
          style: TextStyle(
            color: Color.fromARGB(255, 23, 90, 29),
            fontSize: 25,
             fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Field 1: Full Name
                TextFormField(
                  
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Field 2: Email
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),

                // Field 3: Password
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),

                // Field 4: Confirm Password
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),

                // Field 5: Phone Number
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),

                // New Field: Location
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Image Upload Button
                Center(
                  child: Column(
                    children: [
                      _image != null
                          ? Image.file(
                              _image!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : const Text('No image selected'),
                     Row(
                      children: [
                        const Text("upload id"),
                         const SizedBox(height: 16.0),
                         const SizedBox(width: 10,),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                         fixedSize: const Size(200, 50) ,
                         
                         shape: const RoundedRectangleBorder()
                        ),
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Upload'),
                      ),
                      ],
                     )
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        
                      
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          
                          backgroundColor: Colors.green,
                         
                        ),
                      
                        onPressed: () {
                          // Handle form submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successfully')),
                          );
                        },
                        child: const Text('Signup',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}