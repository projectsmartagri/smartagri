import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:smartagri/modules/admin/screens/signupScreen.dart';

class Adminloginscreen extends StatefulWidget {
  const Adminloginscreen({super.key, String? zone, String? area});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Adminloginscreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        color: Color.fromARGB(255, 234, 246, 234), // Background color (light green)
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Foreground Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Decreased space between title and username/email field
                    SizedBox(height: 240.0), // Reduced the space from 160.0 to 80.0

                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Smart Agri",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(4, 75, 4, 0.961),
                            fontFamily: 'dancing script',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    
                    
                    // Field 1: Username/Email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username/Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),

                    // Field 2: Password
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
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
                    ),
                    const SizedBox(height: 16.0),

                    // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successfully')),
                          );
                        },
                        child: const Text('LOGIN', style: TextStyle(color: Color.fromARGB(255, 3, 105, 49))),
                      ),
                    ),
                    
                    const SizedBox(height: 16.0),
                    Spacer(),

                    // Create Account Button
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(color: const Color.fromARGB(255, 52, 51, 51)),
                          ),
                          TextSpan(
                            text: 'SIGN UP',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              //  Navigator.push(
                                 // context,
                                  //MaterialPageRoute(builder: (context) => signupScreen()),
                               // );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
