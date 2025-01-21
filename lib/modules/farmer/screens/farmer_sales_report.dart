import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProductSalesScreen extends StatefulWidget {
  const ProductSalesScreen({super.key});

  @override
  State<ProductSalesScreen> createState() => _ProductSalesScreenState();
}

class _ProductSalesScreenState extends State<ProductSalesScreen> {
  DateTime? selectedDate;

  final ValueNotifier<double> totalSales = ValueNotifier<double>(0.0);

  Future<List<Map<String, dynamic>>> fetchSalesData(String farmerId) async {
    final ordersSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('isCompleted', isEqualTo: true)
        .get();

    final List<Map<String, dynamic>> salesData = [];
    double overallTotalSales = 0.0;

    for (var order in ordersSnapshot.docs) {
      final orderData = order.data();
      final List items = orderData['items'] ?? [];

      for (var item in items) {
        final String productId = item['productId'];
        final int quantity = item['quantity'];
        final Timestamp date = item['addedAt'];

        // Apply date filter
        if (selectedDate != null &&
            date.toDate().difference(selectedDate!).inDays != 0) {
          continue;
        }

        // Fetch product details from the product collection
        final productSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get();

        final productData = productSnapshot.data();
        if (productData != null && productData['farmerId'] == farmerId) {
          final String title = productData['title'];
          final double price = productData['price'].toDouble();

          // Add individual purchase data to salesData list
          salesData.add({
            'title': title,
            'quantity': quantity,
            'date': date.toDate(),
            'totalSales': quantity * price,
          });

          // Accumulate total sales for all products
          overallTotalSales += quantity * price;
        }
      }
    }

    // Update the ValueNotifier for overall total sales
    totalSales.value = overallTotalSales;

    // Sort by date in descending order
    salesData.sort((a, b) => b['date'].compareTo(a['date']));

    return salesData;
  }

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
   void resetDateFilter() {
    setState(() {
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String farmerId = FirebaseAuth.instance.currentUser!.uid; 

    return Scaffold(
      bottomSheet: Container(
        color: Colors.green.shade800,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: ValueListenableBuilder(
          valueListenable: totalSales,
          builder: (context, value, child) => Text(
            'Total Sales: ₹${value.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Agri Sales Report",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => pickDate(context),
          ),
           if (selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: "Reset Date Filter",
              onPressed: resetDateFilter,
            ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchSalesData(farmerId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error loading sales data"));
            }

            final salesData = snapshot.data ?? [];

            if (salesData.isEmpty) {
              return const Center(child: Text("No sales data available"));
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          Colors.green.shade800,
                        ),
                        dataRowColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 224, 251, 225),
                        ),
                        columnSpacing: 30,
                        columns: const [
                          DataColumn(
                            label: Text(
                              "Product Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Quantity Sold",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Date",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Total Sales",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        rows: salesData.map((productData) {
                          return DataRow(cells: [
                            DataCell(Text(productData['title'])),
                            DataCell(Text(productData['quantity'].toString())),
                            DataCell(Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(productData['date']),
                            )),
                            DataCell(Text(
                              productData['totalSales'].toStringAsFixed(2),
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
