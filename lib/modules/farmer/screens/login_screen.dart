import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/Farmer_signup_screen.dart';
import 'package:smartagri/modules/farmer/screens/homepage_screen.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({super.key});

  @override
  _FarmerLoginScreenState createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
  bool _obscurePassword = true; // To toggle password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _loginHandler() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot farmerDoc = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(uid)
          .get();

      if (!farmerDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User data not found in farmer records.')),
        );
        return;
      }

      bool isApproved = farmerDoc.get('isApproved');
      if (isApproved) {
        // Navigate to Farmer Home Page
        Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerHomeScreen(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin has not approved your account yet.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade700,
              Colors.green.shade500,
              Colors.green.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Spacer(),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Smart Agri",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Dancing Script',
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                // Field 1: Username/Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // Field 2: Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                // Submit Button
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: _isLoading ? null : _loginHandler,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : const Text('LOGIN',
                            style: TextStyle(color: Colors.green)),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Spacer(),
                // Create Account Button
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'SIGN UP',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FarmerSignupScreen(),
                              ),
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
      ),
    );
  }
}
