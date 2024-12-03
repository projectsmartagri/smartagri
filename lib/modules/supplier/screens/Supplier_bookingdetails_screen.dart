import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierBookingDetailsScreen extends StatelessWidget {
  const SupplierBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for bookings and returns, now including payment details
    final List<Map<String, String>> bookings = [
      {
        'farmerName': 'Farmer John',
        'product': 'Tractor',
        'date': '2024-10-01',
        'paymentStatus': 'Paid', // Payment status for Farmer John
        'amount': '20000', // Payment amount for Farmer John
      },
      {
        'farmerName': 'Farmer Alice',
        'product': 'Plough',
        'date': '2024-10-02',
        'paymentStatus': 'Pending', // Payment status for Farmer Alice
        'amount': '15000', // Payment amount for Farmer Alice
      },
    ];

    final List<Map<String, String>> returns = [
      {
        'farmerName': 'Farmer John',
        'product': 'Tractor',
        'date': '2024-10-10',
        'paymentStatus': 'Paid', // Payment status for return
        'amount': '20000', // Payment amount for return
      },
      {
        'farmerName': 'Farmer Alice',
        'product': 'Plough',
        'date': '2024-10-12',
        'paymentStatus': 'Pending', // Payment status for return
        'amount': '15000', // Payment amount for return
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            ); // Navigate back when pressed
          },
        ),
        title: const Text(
          'Booking Details', // Title of the screen
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bookings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Farmer: ${bookings[index]['farmerName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${bookings[index]['product']}'),
                          Text('Date: ${bookings[index]['date']}'),
                          Text(
                            'Payment Status: ${bookings[index]['paymentStatus']}',
                            style: TextStyle(
                              color: bookings[index]['paymentStatus'] == 'Paid' ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            'Amount: ₹${bookings[index]['amount']}', // Format amount in Indian Rupees
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Returns',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: returns.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Farmer: ${returns[index]['farmerName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${returns[index]['product']}'),
                          Text('Return Date: ${returns[index]['date']}'),
                          Text(
                            'Payment Status: ${returns[index]['paymentStatus']}',
                            style: TextStyle(
                              color: returns[index]['paymentStatus'] == 'Paid' ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            'Amount: ₹${returns[index]['amount']}', // Format amount in Indian Rupees
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
