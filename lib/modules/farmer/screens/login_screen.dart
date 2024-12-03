import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/Farmer_signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // To toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'asset/image/image.jpg',
            fit: BoxFit.cover,
          ),
          // Foreground Content
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    const Spacer(),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
<<<<<<< HEAD
                        padding: EdgeInsets.only(bottom: 60.0),
                        child: Text(
                          "SMART AGRI",
=======
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Smart Agri",
>>>>>>> refs/remotes/origin/main
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                             color: Color.fromRGBO(4, 75, 4, 1),
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
                    ),
                    const SizedBox(height: 16.0),

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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successfully')),
                          );
                        },
                        child: const Text('LOGIN', style: TextStyle(color: Colors.white)),
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
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => SignupScreen()),
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
          ),
        ],
      ),
    );
  }
}
