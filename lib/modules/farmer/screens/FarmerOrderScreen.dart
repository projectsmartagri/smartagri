import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final ordersSnapshot =
        await FirebaseFirestore.instance.collection('rental_order').get();

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
                        'Start Date: ${order['rentalDays']}'),
                    Text('End Date: ${order['endDate'].toDate().toLocal()}'),
                    Text(
                      'Total Amount: ₹${order['totalAmount'].toStringAsFixed(2)}',
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
    final supplier = order['supplier'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (order['machinary']?['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  order['machinary']['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            if (supplier?['lat'] != null && supplier?['long'] != null)
                      Row(
                        children: [
                          Text('Location'),
                          Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              _navigateToGoogleMaps(
                                  supplier['lat'], supplier['long']);
                            },
                            icon: const Icon(Icons.map, color: Colors.green),
                            label: const Text(
                              'View on Map',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['machinary']?['name'] ?? 'Unknown Machinery',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Divider(thickness: 1, height: 20),
                    _buildDetailRow('Supplier', supplier?['name']),
                    
                    _buildDetailRow(
                      'Start Date',
                      order['startDate']?.toDate().toLocal().toString(),
                    ),
                    _buildDetailRow(
                      'End Date',
                      order['endDate']?.toDate().toLocal().toString(),
                    ),
                    _buildDetailRow(
                      'Total Amount',
                      '₹${order['totalAmount']?.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Details:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  order['machinary']?['description'] ??
                      'No details available about this machinery.',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            value ?? 'N/A',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToGoogleMaps(double lat, double long) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }
}