import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:smartagri/modules/user/model/user_model.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Register a new user
  Future<UserModel?> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required XFile? profileImage,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Upload profile image if available
        String? imageUrl;
        if (profileImage != null) {
          imageUrl = await _uploadProfileImage(user.uid, profileImage);
        }

        // Create user model
        UserModel newUser = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          phone: phone,
          profileImageUrl: imageUrl,
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());

        return newUser;
      }
      return null;
    } catch (e) {
      print("Error registering user: $e");
      rethrow;
    }
  }

  // Upload profile image to Firebase Storage
  Future<String> _uploadProfileImage(String uid, XFile profileImage) async {
    try {
      Reference ref = _storage.ref().child('profileImages').child(uid);
      await ref.putFile(File(profileImage.path));
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading profile image: $e");
      rethrow;
    }
  }

  // Login user
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error logging in: $e");
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error logging out: $e");
      rethrow;
    }
  }

  // Forgot password
  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending password reset email: $e");
      rethrow;
    }
  }

  // Get current user
  Future<UserModel?> getUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error getting user: $e");
      rethrow;
    }
  }
}
