import 'package:flutter/material.dart';

class FarmerSettingsScreen extends StatelessWidget {
  const FarmerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Notifications Settings Section
            const Text(
              'Notifications Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: true, // Assuming notifications are enabled
              onChanged: (bool value) {
                // Handle notification toggle
              },
            ),
            const SizedBox(height: 20),

         
          
            // Payment Methods Settings Section
            const Text(
              'Payment Methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Add Payment Method'),
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPaymentMethodScreen()),
                );// Navigate to Add Payment Method screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('View Payment History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()),
                ); // Navigate to Payment History screen
              },
            ),
            const SizedBox(height: 20),

            // Privacy Settings Section
            const Text(
              'Privacy Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Share Farm Information with Others'),
              value: true, // Assuming information sharing is enabled
              onChanged: (bool value) {
                // Handle toggle for sharing farm info
              },
            ),
            const SizedBox(height: 20),

         
          ],
        ),
      ),
    );
  }
}











class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  _AddPaymentMethodScreenState createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPaymentMethod = "Credit/Debit Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: const [
                  DropdownMenuItem(
                    value: "Credit/Debit Card",
                    child: Text("Credit/Debit Card"),
                  ),
                  DropdownMenuItem(
                    value: "Bank Account",
                    child: Text("Bank Account"),
                  ),
                  DropdownMenuItem(
                    value: "Mobile Wallet",
                    child: Text("Mobile Wallet"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Payment Method',
                ),
              ),
              const SizedBox(height: 20),
              if (_selectedPaymentMethod == "Credit/Debit Card") ...[
                const Text(
                  'Card Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your card number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expiry Date (MM/YY)',
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ] else if (_selectedPaymentMethod == "Bank Account") ...[
                const Text(
                  'Bank Account Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account Holder Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter account holder name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter account number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bank Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bank name';
                    }
                    return null;
                  },
                ),
              ] else if (_selectedPaymentMethod == "Mobile Wallet") ...[
                const Text(
                  'Mobile Wallet Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Wallet Provider',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter wallet provider';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the payment method
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Method Added')),
                    );
                    Navigator.pop(context); // Return to previous screen
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Add Payment Method',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}












class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        backgroundColor: Colors.green,
      ),
      body: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Tab Bar
            TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green,
              tabs: [
                Tab(icon: Icon(Icons.arrow_upward), text: "Payments to Suppliers"),
                Tab(icon: Icon(Icons.arrow_downward), text: "Payments Received"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Payments to Suppliers
                  _PaymentList(
                    title: "Booking Rental Machinery",
                    payments: [
                      {
                        "date": "2024-11-30",
                        "returnDate": "2024-12-05",
                        "amount": "₹3,500",
                        "details": "Rental of Tractor from Supplier A"
                      },
                      {
                        "date": "2024-11-15",
                        "returnDate": "2024-11-18",
                        "amount": "₹1,200",
                        "details": "Rental of Plough from Supplier B"
                      },
                    ],
                  ),
                  // Payments Received
                  _PaymentList(
                    title: "Selling Products to Customers",
                    payments: [
                      {
                        "date": "2024-12-01",
                        "amount": "₹4,000",
                        "details": "Sale of 100kg Wheat to Customer X"
                      },
                      {
                        "date": "2024-11-28",
                        "amount": "₹1,800",
                        "details": "Sale of 50kg Rice to Customer Y"
                      },
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentList extends StatelessWidget {
  final String title;
  final List<Map<String, String>> payments;

  const _PaymentList({required this.title, required this.payments});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...payments.map(
          (payment) => Card(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              leading: const Icon(Icons.payment, color: Colors.green),
              title: Text(payment["details"]!),
              subtitle: payment.containsKey("returnDate")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("order Date: ${payment["date"]}"),
                        Text("Return Date: ${payment["returnDate"]}"),
                      ],
                    )
                  : Text("Date: ${payment["date"]}"),
              trailing: Text(
                payment["amount"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}









