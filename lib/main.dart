import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:smartagri/Splash_screen.dart';
import 'package:smartagri/firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); 


  OneSignal.initialize("85e5ff2c-dae4-4fb2-b17f-d34db621222c");
  await OneSignal.Notifications.requestPermission(true);



   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  ); 
  
  runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
         
        ),
        home: SplashScreen()),
    ) ;
}


 
