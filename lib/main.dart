import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/firebase_options.dart';
import 'package:smartagri/modules/admin/screen/Admin_homescreen.dart';
import 'package:smartagri/modules/choose_screen.dart';



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
        home: ChooseScreen()),
    ) ;
}


 
