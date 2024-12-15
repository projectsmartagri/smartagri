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
          ),
        ),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Rejected'), // Tab for Rejected suppliers
            Tab(text: 'Approved'), // Tab for Approved suppliers
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
                    'No ${isApproved ? 'approved' : 'Rejected'} suppliers found.'));
          }

          // Extract the suppliers data from the snapshot
          final suppliers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              final name = supplier['name'] ?? 'No Name';
              final email = supplier['email'] ?? 'No Email';

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 40,
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(email),
                  onTap: () {
                    // Navigate to the SupplierDetails page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupplierDetails(
                          companyname: name,
                          email: email,
                          companyName: '',
                          phone: '',
                          address: '',
                          companyDocumentUrl: '',
                          name: '',
                        ),
                      ),
                    );
                  },
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view',
                        child: Text('View'),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'view') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierDetails(
                              name: name,
                              email: email,
                              companyName: '',
                              phone: '',
                              address: '',
                              companyDocumentUrl: '',
                              companyname: '',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$value $name')),
                        );
                      }
                    },
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
