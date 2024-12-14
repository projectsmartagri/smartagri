import 'package:flutter/material.dart';


class Farmerproductorderstatusscreen extends StatelessWidget {
  const Farmerproductorderstatusscreen({super.key});

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
          children: const [
            // Section: Pending Orders
            Text(
              'Pending Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            OrderTile(
              orderId: '#12345',
              customerName: 'John Doe',
              orderDate: 'Nov 30, 2024',
              status: 'Pending',
            ),
            OrderTile(
              orderId: '#12346',
              customerName: 'Jane Smith',
              orderDate: 'Dec 1, 2024',
              status: 'Pending',
            ),
            SizedBox(height: 20),

            // Section: Completed Orders
            Text(
              'Completed Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            OrderTile(
              orderId: '#12340',
              customerName: 'Mark Lee',
              orderDate: 'Nov 25, 2024',
              status: 'Completed',
            ),
            OrderTile(
              orderId: '#12341',
              customerName: 'Alice Brown',
              orderDate: 'Nov 26, 2024',
              status: 'Completed',
            ),
            SizedBox(height: 20),

            // Section: Cancelled Orders
            Text(
              'Cancelled Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            OrderTile(
              orderId: '#12330',
              customerName: 'Chris Taylor',
              orderDate: 'Nov 22, 2024',
              status: 'Cancelled',
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

  const OrderTile({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
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
              subtitle: Text('Order ID: $orderId\nDate: $orderDate'),
            ),
            if (status == 'Pending')
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Farmerproducttrackorder(orderId: '', customerName: '', shipmentStatus: '', trackingStages: [],),
                      ),
                    );*/ // Add logic to track the order
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tracking order $orderId')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Track Order'  ,style: TextStyle(color:Colors.white),),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
