import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:smartagri/modules/user/widgets/custombuttonWidget.dart';

import '../../../../utils/helper.dart';
import '../../../../widgets/custom_text_field.dart';
import 'numberScreen.dart';
import '../view_model/auth_view_model.dart';

class Singinscreen extends StatefulWidget {
  const Singinscreen({super.key});

  @override
  State<Singinscreen> createState() => _SinginscreenState();
}

class _SinginscreenState extends State<Singinscreen> {
  // Controllers for form fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Variable to hold the selected image
  XFile? _profileImage;

  // Function to validate form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;
 

    return Scaffold(
      backgroundColor:  Colors.white,
      bottomSheet: Theme(
        data: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white
          )
        ),
        child :Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Consumer<AuthViewModel>(
            builder: (context,authViewModel,child) {
              return authViewModel.isLoading ?const CircularProgressIndicator(color: Colors.green,)  : CustomButtonWidget(
                text: 'Sign up',
                action: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    // Register user with the email, password, and profile image
                   if(_profileImage != null){

                     await authViewModel.registerUser(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                      name: usernameController.text,
                      phone: phoneController.text,
                      profileImage: _profileImage,
                       // Pass the selected image here
                    );
                   }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('select profile image')));

                   }
              
                    
                  }
                },
              );
            }
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: ht,
          width: wt,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Background Image
                Image.asset(
                  'asset/images/sing.png',
                  width: wt,
                  height: ht / 3.5,
                  fit: BoxFit.cover,
                ),
                
                // Overlay Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get your groceries\nwith nectar',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      const SizedBox(height: 20),
                  
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _profileImage = image;
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 2),
                              image: _profileImage != null
                                  ? DecorationImage(
                                      image: FileImage(File(_profileImage!.path)),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _profileImage == null
                                ? const Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.black54,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                  
                      // Username Input Field
                      CustomTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        validator: ValidationHelper.validateUsername,
                      ),
                      const SizedBox(height: 20),
                  
                      // Email Input Field
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidationHelper.validateEmail,
                      ),
                      const SizedBox(height: 20),
                  
                      // Password Input Field
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        validator: ValidationHelper.validatePassword,
                      ),
                      const SizedBox(height: 20),
                  
                      // Phone Input Field
                      PhoneFormField(
                        initialValue: PhoneNumber.parse('+91'),
                        countrySelectorNavigator:
                            const CountrySelectorNavigator.page(),
                        onChanged: (phoneNumber) {
                          phoneController.text = phoneNumber.nsn;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
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
