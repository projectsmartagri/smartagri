import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerOrdersScreen extends StatelessWidget {
  final String farmerId; // Farmer's unique ID

  const FarmerOrdersScreen({super.key, required this.farmerId});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    // Fetch orders from the 'order' collection
    final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();

    List<Map<String, dynamic>> farmerOrders = [];

    for (var orderDoc in ordersSnapshot.docs) {
      var orderData = orderDoc.data();

      // Loop through each product in the order
      for (var product in orderData['items']) {
        final productId = product['productId'];

        // Fetch the corresponding product document from the 'products' collection
        final productDoc = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get();

        if (productDoc.exists && productDoc.data()?['farmerId'] == farmerId) {
          // If the farmerId matches, add the order to the result
          orderData['items'] = product; // Add only this product item
          orderData['orderId'] = orderDoc.id; // Include the order ID
          farmerOrders.add(orderData);
        }
      }
    }
    return farmerOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Orders"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching orders"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final product = order['items'];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID: ${order['orderId']}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text("Product: ${product['name']}"),
            Text("Quantity: ${product['quantity']}"),
            Text("Total Amount: \$${order['totalAmount']}"),
            Text(
              "Order Placed At: ${(order['timestamp'] as Timestamp).toDate()}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Image.network(
              product['imageUrl'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
