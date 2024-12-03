import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartagri/utils/helper.dart';

class FarmerAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 

  // Function to register a supplier with email, password, and additional details
  Future<void> registerFarmer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required File Farmerid, // Image file for the company license
  }) async {
    try {
      // Create user with email and password in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID
      String uid = userCredential.user!.uid;

      // Upload the company license image to Firebase Storage
      String farmeridurl = await uploadfile(
        name: 'Farmer id',
        uid: uid,
        file: Farmerid
      );

      // Save supplier data in Firestore
      await _firestore.collection('farmer').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'farmeridurl': farmeridurl, // URL of the uploaded company license
        'isApproved': false, // Default value for new suppliers
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('Supplier registered successfully!');
    } catch(e){

      rethrow;
    }
  }
  // Function to log in a supplier using email and password
  Future<bool> loginSupplier({
    required String email,
    required String password,
  }) async {
    try {
      // Log in with email and password using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve the supplier's Firestore document
      DocumentSnapshot supplierDoc = await _firestore.collection('farmer').doc(userCredential.user!.uid).get();

      if (supplierDoc.exists) {
        // Supplier exists in Firestore


         Map<String, dynamic> supplierData =
          supplierDoc.data() as Map<String, dynamic>;

      // Check if the supplier is approved
      bool isApproved = supplierData['isApproved'] ?? false;

      if (isApproved) {
         return true;
      }else{
        throw 'Admin not approved';
      }
        
      } else {
        throw('Error: farmer record not found in Firestore.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle login errors from Firebase Authentication
      print('Error: ${e.message}');
      rethrow; // Rethrow the error to pass it up the call stack
    } catch (e) {
      // Handle any other errors
      print('Error: $e');
      rethrow; // Rethrow the error to pass it up the call stack
    }
  }

 
}
