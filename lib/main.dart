import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/firebase_options.dart';
import 'package:smartagri/modules/farmer/screens/homepage_screen.dart';
import 'package:smartagri/modules/farmer/screens/login_screen.dart';
import 'package:smartagri/modules/farmer/screens/signup_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); 


   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  ); 
  
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
       
      ),
      home:HomepageScreen()) ,);
}


 
