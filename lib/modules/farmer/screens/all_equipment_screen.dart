import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/farmer/screens/farmequipmentdetails.dart';

class MachineryListScreen extends StatelessWidget {
  const MachineryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farm Machinery',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 6,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('machinary').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No machinery available.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final machineryList = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              childAspectRatio: .6, // Aspect ratio to control card size
            ),
            itemCount: machineryList.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final machinery = machineryList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                margin: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.green[200]!, Colors.green[700]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Machinery Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                machinery['image'],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Machinery Name
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                machinery['name'],
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Price Text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '₹${machinery['price']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),

                        // Availability Icon (top-right)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            machinery['availability'] == "Available"
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: machinery['availability'] == "Available"
                                ? Colors.green
                                : Colors.red,
                            size: 28,
                          ),
                        ),

                        // Details Button at the bottom
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle the "Details" button press
                             Navigator.push(context,MaterialPageRoute(builder: (context) => EquipmentDetailsScreen(
                              machinery: machinery.data(),
                              id: machinery.id,

                             ),) );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
