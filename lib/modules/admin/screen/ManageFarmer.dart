import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/admin/screen/FarmerDetails.dart';

class ManageFarmer extends StatefulWidget {
  const ManageFarmer({super.key});

  @override
  State<ManageFarmer> createState() => _ManageFarmerState();
}

class _ManageFarmerState extends State<ManageFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Management'),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFarmersList('pending'),
          _buildFarmersList('approved'),
        ],
      ),
    );
  }

  Widget _buildFarmersList(String status) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('farmers')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data found.'));
        }

        final farmers = snapshot.data!.docs;
        return ListView.builder(
          itemCount: farmers.length,
          itemBuilder: (context, index) {
            final farmer = farmers[index];
            final name = farmer['name'] ?? 'No Name';
            final location = farmer['location'] ?? 'No Location';
            final contact = farmer['phone'] ?? 'No Phone';
            final pdfUrl = farmer['pdfUrl'] ?? '';

            return _buildFarmerCard(
                context, name, location, contact, pdfUrl);
          },
        );
      },
    );
  }

  Widget _buildFarmerCard(BuildContext context, String name, String location,
      String contact, String pdfUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Text('Location: $location'),
            Text('Contact: $contact'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Open PDF link
              },
              child: Row(
                children: const [
                  Icon(Icons.picture_as_pdf, color: Colors.red),
                  SizedBox(width: 4),
                  Text(
                    'View Document',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
