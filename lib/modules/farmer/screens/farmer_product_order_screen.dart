import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FarmerProductOrdersScreen extends StatelessWidget {
  final String farmerId; // Farmer's unique ID

  const FarmerProductOrdersScreen({super.key, required this.farmerId});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();

    List<Map<String, dynamic>> farmerOrders = [];

    for (var orderDoc in ordersSnapshot.docs) {
      var orderData = orderDoc.data();

      for (var product in orderData['items']) {
        final productId = product['productId'];

        final productDoc = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get();

        if (productDoc.exists && productDoc.data()?['farmerId'] == FirebaseAuth.instance.currentUser!.uid) {
          orderData['items'] = product;
          orderData['orderId'] = orderDoc.id;
          farmerOrders.add(orderData);
        }
      }
    }

    // Sort orders by timestamp (latest first)
    farmerOrders.sort((a, b) => (b['timestamp'] as Timestamp).compareTo(a['timestamp'] as Timestamp));

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
          Map<String, List<Map<String, dynamic>>> groupedOrders = {};

          for (var order in orders) {
            String dateKey = DateFormat('yyyy-MM-dd').format((order['timestamp'] as Timestamp).toDate());
            groupedOrders.putIfAbsent(dateKey, () => []).add(order);
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: groupedOrders.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key, // Date heading
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  ...entry.value.map((order) => OrderCard(order: order)).toList(),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
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
            Text("Total Amount: ₹${order['totalAmount']}"),
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
