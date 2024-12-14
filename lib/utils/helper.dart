// lib/utils/validation_helper.dart

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ValidationHelper {
  // Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  // Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}

final FirebaseStorage _storage = FirebaseStorage.instance;


 // Helper function to upload the company license image to Firebase Storage
  Future<String> uploadfile({required String name,required String uid,required File file}) async {
    try {
      // Define the storage path for the company license
      Reference storageRef = _storage.ref().child('machinary/');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading company license: $e');
      rethrow;
    }
  }

