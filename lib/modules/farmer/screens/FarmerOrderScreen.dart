import 'package:flutter/material.dart';

class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section: Pending Orders
            const Text(
              'Pending Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OrderTile(
              orderId: '#12345',
              customerName: 'John Doe',
              orderDate: 'Nov 30, 2024',
              status: 'Pending',
              productName: 'Tractor Rental',
              productPrice: 200.0,
            ),
            OrderTile(
              orderId: '#12346',
              customerName: 'Jane Smith',
              orderDate: 'Dec 1, 2024',
              status: 'Pending',
              productName: 'Wheat Seeds',
              productPrice: 50.0,
            ),
            const SizedBox(height: 20),

            // Section: Completed Orders
            const Text(
              'Completed Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OrderTile(
              orderId: '#12340',
              customerName: 'Mark Lee',
              orderDate: 'Nov 25, 2024',
              status: 'Completed',
              productName: 'Corn Seeds',
              productPrice: 75.0,
            ),
            OrderTile(
              orderId: '#12341',
              customerName: 'Alice Brown',
              orderDate: 'Nov 26, 2024',
              status: 'Completed',
              productName: 'Pesticide',
              productPrice: 30.0,
            ),
            const SizedBox(height: 20),

            // Section: Cancelled Orders
            const Text(
              'Cancelled Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OrderTile(
              orderId: '#12330',
              customerName: 'Chris Taylor',
              orderDate: 'Nov 22, 2024',
              status: 'Cancelled',
              productName: 'Irrigation System',
              productPrice: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying individual order details
class OrderTile extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String orderDate;
  final String status;
  final String productName;
  final double productPrice;

  const OrderTile({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.status,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          status == 'Pending'
              ? Icons.pending
              : status == 'Completed'
                  ? Icons.check_circle
                  : Icons.cancel,
          color: status == 'Pending'
              ? Colors.orange
              : status == 'Completed'
                  ? Colors.green
                  : Colors.red,
        ),
        title: Text(customerName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId'),
            Text('Date: $orderDate'),
            Text('Product: $productName'),
            Text('Price: \$${productPrice.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
