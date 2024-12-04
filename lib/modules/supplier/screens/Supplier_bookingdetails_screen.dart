import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierBookingDetailsScreen extends StatelessWidget {
  const SupplierBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for bookings and completed items
    final List<Map<String, String>> bookings = [
      {
        'farmerName': 'Farmer John',
        'product': 'Tractor',
        'date': '2024-10-01',
        'paymentStatus': 'Paid',
        'amount': '20000',
      },
      {
        'farmerName': 'Farmer Alice',
        'product': 'Plough',
        'date': '2024-10-02',
        'paymentStatus': 'Pending',
        'amount': '15000',
      },
    ];

    final List<Map<String, String>> completed = [
      {
        'farmerName': 'Farmer John',
        'product': 'Tractor',
        'date': '2024-10-10',
        'paymentStatus': 'Paid',
        'amount': '20000',
      },
      {
        'farmerName': 'Farmer Alice',
        'product': 'Plough',
        'date': '2024-10-12',
        'paymentStatus': 'Pending',
        'amount': '15000',
      },
    ];

    // Filter completed items to show only those where paymentStatus is 'Paid'
    final List<Map<String, String>> completedPaid = completed
        .where((item) => item['paymentStatus'] == 'Paid')
        .toList();

    double totalBookingAmount = bookings.fold(0, (sum, item) => sum + double.parse(item['amount']!));
    double totalCompletedAmount = completedPaid.fold(0, (sum, item) => sum + double.parse(item['amount']!));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            );
          },
        ),
        title: const Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView( // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bookings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Farmer')),
                          DataColumn(label: Text('Product')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Payment Status')),
                          DataColumn(label: Text('Amount')),
                        ],
                        rows: bookings.map((booking) {
                          return DataRow(
                            cells: [
                              DataCell(Text(booking['farmerName']!)),
                              DataCell(Text(booking['product']!)),
                              DataCell(Text(booking['date']!)),
                              DataCell(
                                Text(
                                  booking['paymentStatus']!,
                                  style: TextStyle(
                                    color: booking['paymentStatus'] == 'Paid' ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              DataCell(Text('₹${booking['amount']}')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('₹$totalBookingAmount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Farmer')),
                          DataColumn(label: Text('Product')),
                          DataColumn(label: Text('Return Date')),
                          DataColumn(label: Text('Payment Status')),
                          DataColumn(label: Text('Amount')),
                        ],
                        rows: completedPaid.map((completedData) {
                          return DataRow(
                            cells: [
                              DataCell(Text(completedData['farmerName']!)),
                              DataCell(Text(completedData['product']!)),
                              DataCell(Text(completedData['date']!)),
                              DataCell(
                                Text(
                                  completedData['paymentStatus']!,
                                  style: TextStyle(
                                    color: completedData['paymentStatus'] == 'Paid' ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              DataCell(Text('₹${completedData['amount']}')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('₹$totalCompletedAmount',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
