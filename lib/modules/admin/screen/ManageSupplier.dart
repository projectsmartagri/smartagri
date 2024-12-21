import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/admin/screen/SupplierDetails.dart';

class ManageSupplierScreen extends StatefulWidget {
  const ManageSupplierScreen({super.key});

  @override
  State<ManageSupplierScreen> createState() => _ManageSupplierScreenState();
}

class _ManageSupplierScreenState extends State<ManageSupplierScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Supplier',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.green.shade600,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSuppliersList(false), // Rejected suppliers (isApproved == false)
          _buildSuppliersList(true),  // Approved suppliers (isApproved == true)
        ],
      ),
    );
  }

  // Function to fetch and display supplier list based on approval status
  Widget _buildSuppliersList(bool isApproved) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('suppliers')
            .where('isApproved', isEqualTo: isApproved) // Filter by isApproved field
            .snapshots(),
        builder: (context, snapshot) {
          // Handle the connection state (waiting for data)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle the case when there is no data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No ${isApproved ? 'approved' : 'rejected'} suppliers found.',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          // Extract the suppliers data from the snapshot
          final suppliers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              final name = supplier['name'] ?? 'No Name';
              final email = supplier['email'] ?? 'No Email';
              final phone = supplier['phone'] ?? 'No Phone';
              
              final address = supplier['address'] ?? 'No Address';
              final companyLicenseUrl = supplier['companyLicenseUrl'] ?? '';
              final isApproved = supplier['isApproved'] ?? false;

              return Card(
                elevation: 6, // Elevated effect
                margin: const EdgeInsets.symmetric(vertical: 12), // Adjusted margin
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners for a softer look
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to the SupplierDetails page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupplierDetails(
                          email: email,
                          phone: phone,
                          address: address,
                          companyLicenseUrl: companyLicenseUrl,
                          name: name,
                          isApproved: isApproved, supplierId: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          isApproved ? Colors.green.shade100 : Colors.red.shade100,
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15), // Rounded corners for gradient
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.green.shade700,
                        size: 45,
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green.shade700,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            email,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Address: $address',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        isApproved ? Icons.check_circle : Icons.pending,
                        color: isApproved ? Colors.green : Colors.red,
                        size: 30,
                      ),
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
