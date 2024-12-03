import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/user/screens/signupScreen.dart';

class UserLoginscreen extends StatefulWidget {
  const UserLoginscreen({super.key, String? zone, String? area});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<UserLoginscreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
<<<<<<< HEAD:lib/modules/user/screens/loginScreen.dart
      body: Stack(
        fit: StackFit.expand,
        children: [
            
         // Image.asset(
            //'asset/image/image.jpg',
           // fit: BoxFit.cover,
        //  ),
          // Foreground Content
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
=======
      body: Container(
        color: Color.fromARGB(255, 242, 244, 242), // Background color (light green)
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Foreground Content
            Padding(
>>>>>>> refs/remotes/origin/main:lib/modules/user/screens/User_loginScreen.dart
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
<<<<<<< HEAD:lib/modules/user/screens/loginScreen.dart
                    
                    const Spacer(),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60.0),
                        child: Text(
                          "SMART AGRI",
=======
                    // Decreased space between title and username/email field
                    SizedBox(height: 240.0), // Reduced the space from 160.0 to 80.0

                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Smart Agri",
>>>>>>> refs/remotes/origin/main:lib/modules/user/screens/User_loginScreen.dart
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color.fromARGB(255, 65, 154, 68),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successfully')),
                          );
                        },
                        child: const Text('LOGIN', style: TextStyle(fontSize:16 ,color: Color.fromARGB(255, 236, 243, 239))),
                      ),
                    ),
                    
<<<<<<< HEAD:lib/modules/user/screens/loginScreen.dart
                    const SizedBox(height: 16.0),
                    const Spacer(),
=======
                    const SizedBox(height:16.0),
                    Spacer(),
>>>>>>> refs/remotes/origin/main:lib/modules/user/screens/User_loginScreen.dart

                    // Create Account Button
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(color: Color.fromARGB(255, 52, 51, 51)),
                          ),
                          TextSpan(
                            text: 'SIGN UP',
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const signupScreen()),
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
          ],
        ),
      ),
    );
  }
}
