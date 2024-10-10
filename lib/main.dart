import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/firebase_options.dart';
import 'package:smartagri/modules/farmer/screens/signup_screen.dart';
import 'package:smartagri/modules/supplier/screens/EquipmentListPage_screen.dart';
import 'package:smartagri/modules/supplier/screens/LoginScreen.dart';
import 'package:smartagri/modules/supplier/screens/OtherCompaniesScreen.dart';
import 'package:smartagri/modules/supplier/screens/SignUpScreen.dart';

import 'package:smartagri/modules/supplier/screens/home_screen.dart';
import 'package:smartagri/modules/user/screens/homeScreen.dart';
import 'package:smartagri/modules/user/screens/loginScreen.dart';
import 'package:smartagri/modules/user/screens/signupScreen.dart';



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
      home: Homescreen()) ,);
}


 
