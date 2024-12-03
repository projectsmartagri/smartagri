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
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: supplierData!['logo'] != null
                            ? NetworkImage(supplierData!['logo'])
                            : const AssetImage('assets/images/company_logo.png')
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Company Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supplierData!['name'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supplierData!['email'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Phone Number',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supplierData!['phone'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supplierData!['address'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Company License',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: supplierData!['companyLicenseUrl'] != null
                          ? Image.network(
                              supplierData!['companyLicenseUrl'],
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : const Text('No license image available'),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SupplierEditProfileScreen()),
                          );
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
