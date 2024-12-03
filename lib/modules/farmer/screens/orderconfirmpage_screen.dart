import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/ordersdisplay_screen.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderNumber;

  // Constructor to accept an order number
  const OrderSuccessPage({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Successful'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 16),
          
              // Success Message
              const Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
          
              // Order Number Display
              Text(
                'Order Number: $orderNumber',
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
          
              // View Order Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the order details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>OrderDetailsPage(orderNumber: orderNumber),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text('View Order'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy Order Details Page for demonstration
class OrderDetailsPage extends StatelessWidget {
  final String orderNumber;

  const OrderDetailsPage({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Center(
        child: Text(
          'Details for Order Number: $orderNumber',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
