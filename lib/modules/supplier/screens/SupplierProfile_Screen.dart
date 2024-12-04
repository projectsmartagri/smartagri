import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/supplier/screens/SupplierEditProfile_Screen.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierProfileScreen extends StatefulWidget {
  const SupplierProfileScreen({super.key});

  @override
  State<SupplierProfileScreen> createState() => _SupplierProfileScreenState();
}

class _SupplierProfileScreenState extends State<SupplierProfileScreen> {
  // Placeholder for supplier data
  Map<dynamic, dynamic>? supplierData;
  bool _showLicense = false; // Flag to control license image visibility

  @override
  void initState() {
    super.initState();
    fetchSupplierDetails();
  }

  // Fetch supplier details from Firestore
  Future<void> fetchSupplierDetails() async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot supplierDoc = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(id)
          .get();

      setState(() {
        supplierData = supplierDoc.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error fetching supplier details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C8D3D), // Greenish color for agri theme
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SupplierHomeScreen()),
            );
          },
        ),
        title: const Text(
          'Supplier Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: supplierData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo Section
                    Card(
                      color: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: supplierData!['logo'] != null
                                    ? NetworkImage(supplierData!['logo'])
                                    : const AssetImage('assets/images/company_logo.png')
                                        as ImageProvider,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Profile Information Section
                    Card(
                      color: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildProfileInfo('Company Name', supplierData!['name']),
                            const Divider(),
                            _buildProfileInfo('Email', supplierData!['email']),
                            const Divider(),
                            _buildProfileInfo('Phone Number', supplierData!['phone']),
                            const Divider(),
                            _buildProfileInfo('Address', supplierData!['address']),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Company License Section
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Color(0xFF5C8D3D), // Green color for the license section
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Company License',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showLicense = !_showLicense; // Toggle license visibility
                                      });
                                    },
                                    child: Text(
                                      _showLicense ? 'Hide License' : 'Show License',
                                      style: const TextStyle(color: Colors.white), // White text for the button
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF8D6E63), // Brownish button color
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  if (_showLicense)
                                    supplierData!['companyLicenseUrl'] != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                                            child: Center(
                                              child: Image.network(
                                                supplierData!['companyLicenseUrl'],
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 16.0),
                                            child: Center(
                                              child: Text(
                                                'No license image available',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Edit Profile Button Section
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Light brown color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SupplierEditProfileScreen()),
                              );
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Method to build profile info sections
  Widget _buildProfileInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value ?? 'N/A', style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
