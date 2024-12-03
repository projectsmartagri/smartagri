import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/user/screens/bottomnavigationbar.dart';
import 'package:smartagri/modules/user/screens/loginScreen.dart';


import '../model/user_model.dart';
import '../services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  // Register user
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required XFile? profileImage,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserModel? newUser = await _authService.registerUser(
        email: email,
        password: password,
        name: name,
        phone: phone,
        profileImage: profileImage,
      );

      _user = newUser;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Loginscreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login user
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      UserModel? existingUser = await _authService.loginUser(
        email: email,
        password: password,
      );

      _user = existingUser;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Bottomnavigationbar(zone: null, area: null),
        ),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Failed')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout user
  Future<void> logout(BuildContext context) async {
    try {
      await _authService.logout();
      _user = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout Successful')),
      );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Loginscreen(),), (route) => false,);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout Failed')),
      );
    }
  }

  // Forgot password
  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _authService.forgotPassword(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send password reset email')),
      );
    }
  }

  // Get current user
  Future<void> getUser() async {
    try {
      _isLoading = true;
      notifyListeners();

      UserModel? currentUser = await _authService.getUser();
      _user = currentUser;
    } catch (e) {
      print("Error getting user: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
