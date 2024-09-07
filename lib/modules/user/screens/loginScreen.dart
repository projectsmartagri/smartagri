import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:smartagri/modules/user/screens/forget_password_screen.dart';
import 'package:smartagri/modules/user/screens/singinScreen.dart';
import 'package:smartagri/modules/user/widgets/custombuttonWidget.dart';
import 'package:smartagri/utils/helper.dart';

import '../../../../widgets/custom_text_field.dart';
import 'bottomnavigationbar.dart';
import '../view_model/auth_view_model.dart'; // Import your ViewModel

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key, this.zone, this.area});
  String? zone;
  String? area;

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    print(widget.area);

    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    // Access AuthViewModel using Provider
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset('asset/images/carrot_color.png'),
                const SizedBox(height: 80),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Log In',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: const Color(0xff181725),
                            fontSize: ht / 34.59,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your email and password',
                        style:
                            TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 35),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          ValidationHelper.validateEmail(value),
                    ),
                    const SizedBox(height: 35),
                    CustomTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      obscureText: obscureText,
                      validator: (value) =>
                          ValidationHelper.validatePassword(value),
                      suffixIcon: IconButton(
                        icon: Icon(obscureText
                            ? Icons.visibility
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),));
                          
                        
                        },
                        child: const Text(
                          'Forgot Password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    authViewModel.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : CustomButtonWidget(
                            text: 'Login',
                            action: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                authViewModel.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => Singinscreen(),));
                                // Handle sign up navigation
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
