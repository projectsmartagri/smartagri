import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/paymentpage_screen.dart';

class DateFormScreen extends StatefulWidget {
  @override
  _DateFormScreenState createState() => _DateFormScreenState();
}

class _DateFormScreenState extends State<DateFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Use controllers to manage date inputs
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  String _name = '';
  String _address = '';

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        // Format the date and update the appropriate controller
        final formattedDate = "${picked.toLocal().year}-${picked.toLocal().month.toString().padLeft(2, '0')}-${picked.toLocal().day.toString().padLeft(2, '0')}";
        if (isFromDate) {
          _fromDateController.text = formattedDate;
        } else {
          _toDateController.text = formattedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the data
      print('From Date: ${_fromDateController.text}');
      print('To Date: ${_toDateController.text}');
      print('Name: $_name');
      print('Address: $_address');

      // Navigate to PaymentPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _fromDateController,
                          decoration: InputDecoration(
                            labelText: 'From Date',
                            hintText: 'Select Date',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _toDateController,
                          decoration: InputDecoration(
                            labelText: 'To Date',
                            hintText: 'Select Date',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 105, 199, 108),
                  shape: const RoundedRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
