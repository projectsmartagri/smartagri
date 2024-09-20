import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? cardNumber;
  String? cardHolderName;
  String? expiryDate;
  String? cvv;

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      // Process payment here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing Payment...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
                onChanged: (value) {
                  cardNumber = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cardholder Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
                onChanged: (value) {
                  cardHolderName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
                onChanged: (value) {
                  expiryDate = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
                onChanged: (value) {
                  cvv = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPayment,
                child: Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
