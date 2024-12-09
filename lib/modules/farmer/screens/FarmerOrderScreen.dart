import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final ordersSnapshot =
        await FirebaseFirestore.instance.collection('orders').get();

    List<Map<String, dynamic>> orders = [];
    for (var doc in ordersSnapshot.docs) {
      var order = doc.data();
      order['id'] = doc.id;

      // Fetch supplier details
      final supplierSnapshot = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(order['supplierId'])
          .get();
      order['supplier'] = supplierSnapshot.data();

      // Fetch machinery details
      final machinerySnapshot = await FirebaseFirestore.instance
          .collection('machinary')
          .doc(order['machineryId'])
          .get();
      order['machinary'] = machinerySnapshot.data();

      orders.add(order);
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Orders',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 2,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching orders'),
            );
          }

          // Group orders into Ongoing and Completed
          final ongoingOrders = snapshot.data!
              .where((order) => order['endDate'].toDate().isAfter(DateTime.now()))
              .toList();
          final completedOrders = snapshot.data!
              .where((order) =>
                  order['endDate'].toDate().isBefore(DateTime.now()))
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SectionHeader(title: 'Ongoing Orders'),
              ...ongoingOrders.map((order) => OrderTile(order: order)),

              const SizedBox(height: 20),

              const SectionHeader(title: 'Completed Orders'),
              ...completedOrders.map((order) => OrderTile(order: order)),
            ],
          );
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                order['endDate'].toDate().isAfter(DateTime.now())
                    ? Icons.timelapse
                    : Icons.check_circle,
                color: order['endDate'].toDate().isAfter(DateTime.now())
                    ? Colors.orange
                    : Colors.green,
                size: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['machinary']?['name'] ?? 'Unknown Machinery',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Supplier: ${order['supplier']?['name'] ?? 'Unknown'}'),
                    Text(
                        'Start Date: ${order['startDate'].toDate().toLocal()}'),
                    Text('End Date: ${order['endDate'].toDate().toLocal()}'),
                    Text(
                      'Total Amount: \$${order['totalAmount'].toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
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

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (order['machinary']?['image'] != null)
              Image.network(
                order['machinary']['image'],
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              'Machinery: ${order['machinary']?['name'] ?? 'Unknown'}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Supplier: ${order['supplier']?['name'] ?? 'Unknown'}'),
            const SizedBox(height: 8),
            Text('Start Date: ${order['startDate'].toDate().toLocal()}'),
            const SizedBox(height: 8),
            Text('End Date: ${order['endDate'].toDate().toLocal()}'),
            const SizedBox(height: 8),
            Text(
              'Total Amount: \$${order['totalAmount'].toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Details:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(order['machinary']?['description'] ?? 'No details available'),
          ],
        ),
      ),
    );
  }
}
