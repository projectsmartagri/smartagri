import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartagri/utils/helper.dart';

class SupplierMachineryService {

   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final  FirebaseAuth  _auth = FirebaseAuth.instance;


   Future<void> addMachinary(String name,String desc,double price,String avail,File image, File file) async
   {
    try
    {


      String ? uid=_auth.currentUser?.uid;

      
      
     if(uid!=null){

       String url=await  uploadfile(name: 'machinery', uid: uid, file: image);


       await _firestore.collection('machinary').add({
        'userid': _auth.currentUser?.uid,
        'name' : name,
        'description':desc,
        'price':price,
        'availability':avail,
        'image':url,
        

         

      });



     }



    

    }
     catch(e){
      rethrow;

     }
   }




}