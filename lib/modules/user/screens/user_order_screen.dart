import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'You are not logged in.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: user.uid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final orders = snapshot.data?.docs ?? [];

            if (orders.isEmpty) {
              return const Center(
                child: Text(
                  'No orders found!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final orderData = order.data() as Map<String, dynamic>;
                final items = orderData['items'] as List<dynamic>? ?? [];
                final totalAmount = orderData['totalAmount'] ?? 0.0;
                final timestamp = orderData['timestamp'] as Timestamp?;
                final formattedDate = timestamp != null
                    ? DateTime.fromMillisecondsSinceEpoch(
                        timestamp.millisecondsSinceEpoch)
                    : null;

                return Card(
                  elevation: 5,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Date: ${formattedDate != null ? '${formattedDate.day}/${formattedDate.month}/${formattedDate.year}' : 'N/A'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ₹${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: items.map((item) {
                            final itemData = item as Map<String, dynamic>;
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  itemData['imageUrl'] ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                itemData['name'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Price: ₹${itemData['price']}, Quantity: ${itemData['quantity']}',
                              ),
                              trailing: Text(
                                '₹${(itemData['price'] * itemData['quantity']).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Navigate to detailed order view if required
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.teal,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        //   child: const Text(
                        //     'View Details',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        // ),
                      
                      
                      
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
