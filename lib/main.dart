import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/firebase_options.dart';
import 'package:smartagri/modules/farmer/screens/homepage_screen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierLoginScreen.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/user/view_model/auth_view_model.dart';
import 'modules/user/screens/bottomnavigationbar.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); 


   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  ); 
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
         
        ),
        home: SupplierLoginScreen()),
    ) ,);
}


 
