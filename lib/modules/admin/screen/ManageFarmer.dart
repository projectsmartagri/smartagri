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
        title: const Text(
          'Farmer Management',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
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
          _buildFarmersList(false), // Pending farmers
          _buildFarmersList(true),  // Approved farmers
        ],
      ),
    );
  }

  Widget _buildFarmersList(bool isApproved) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('farmers')
          .where('isApproved', isEqualTo: isApproved)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              isApproved ? 'No approved farmers found.' : 'No pending farmers found.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          );
        }

        final farmers = snapshot.data!.docs;
        return ListView.builder(
          itemCount: farmers.length,
          itemBuilder: (context, index) {
            final farmer = farmers[index];
            final name = farmer['name'] ?? 'No Name';
            final email = farmer['email'] ?? 'No Email';
            final farmerIdUrl = farmer['farmerIdUrl'] ?? '';  // Placeholder image if none exists
            final isApproved = farmer['isApproved'] ?? false;
            final phone = farmer['phone'] ?? 'No Phone';
            final location = farmer['location'] ?? 'No Location';

            return _buildFarmerCard(context, name, email, farmerIdUrl, isApproved, phone, location);
          },
        );
      },
    );
  }

  Widget _buildFarmerCard(
    BuildContext context,
    String name,
    String email,
    String farmerIdUrl,
    bool isApproved,
    String phone,
    String location,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to FarmerDetails page with farmer details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerDetails(
              name: name,
              email: email,
              farmerIdUrl: farmerIdUrl,
              isApproved: isApproved, 
              phone: phone,
              location: location,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 10,  // Increased elevation for a more floating effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),  // Rounded corners for a soft look
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isApproved ? Colors.green.shade100 : Colors.orange.shade100,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),  // Rounded corners for gradient effect
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Person icon with a fresh look
                Icon(
                  Icons.person,
                  color: isApproved ? Colors.green.shade700 : Colors.orange.shade700,
                  size: 40,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isApproved ? Colors.green.shade700 : Colors.orange.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Email: $email',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Location: $location',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isApproved ? Icons.check_circle : Icons.pending,
                  color: isApproved ? Colors.green : Colors.orange,
                  size: 32,
                ),
              ],
            ),
          ),
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
