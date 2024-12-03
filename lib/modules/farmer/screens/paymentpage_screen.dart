import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:smartagri/modules/farmer/screens/orderconfirmpage_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text input fields
  final _cardNumberController = TextEditingController();
  final _expiryDateController = MaskedTextController(mask: '00/00');
  final _cvvController = TextEditingController();
  final _nameOnCardController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameOnCardController.dispose();
    super.dispose();
  }

  // Function to handle payment submission and navigate to OrderConfirmPage
  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      // Navigate to OrderConfirmPage on successful validation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OrderSuccessPage(orderNumber: 'asdfghj',)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name on Card Field
              TextFormField(
                controller: _nameOnCardController,
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name on the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Card Number Field
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card number';
                  } else if (value.length != 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Expiry Date Field (with MM/YY format)
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  } else if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Enter expiry date as MM/YY';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CVV Field
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true, // Hide CVV input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  } else if (value.length != 3) {
                    return 'CVV must be 3 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text('Submit Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Order Confirm Page to show successful order message
class OrderConfirmPage extends StatelessWidget {
  const OrderConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Thank you for your purchase.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

