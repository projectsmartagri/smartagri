import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartagri/utils/helper.dart';

class SupplierMachineryService {

   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final  FirebaseAuth  _auth = FirebaseAuth.instance;


   Future<void> addMachinary(String name,String desc,double price,String avail,File image) async
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


   Future<void>machinarydel(String id)async{
        try{
         await  _firestore.collection('machinary').doc(id).delete();

        }
        catch(e){
          rethrow;
        }

      }
       Future<void>machinaryedit({required String name,required imageUrl,required rentRate,required description,required quantity,required id})async{
        try{
         await  _firestore.collection('machinary').doc(id).update(
          {
            'description':description,
            'image':imageUrl,
            'name':name,
            'price':rentRate,
            'Quantity':quantity,


          }
         );

        }
        catch(e){
          rethrow;
        }

      }







}