import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/utils/helper.dart';
import 'package:smartagri/widgets/custom_text_field.dart';

import '../view_model/auth_view_model.dart'; // Import your AuthViewModel

import '../widgets/custombuttonWidget.dart'; // Import your CustomButton

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter your email address below to \nreceive a password reset link.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value)  => ValidationHelper.validateEmail(value)
              ),
            ),
            const SizedBox(height: 20),
            authViewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green,))
                : CustomButtonWidget(
                    text: 'Send Reset Link',
                    action: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        authViewModel.forgotPassword(
                          email: _emailController.text,
                          context: context,
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
