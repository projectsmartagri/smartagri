import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/screens/EquipmentListPage_screen.dart';

class OtherCompaniesScreen extends StatelessWidget {
  const OtherCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Companies',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between title and list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('suppliers')
                    .where(FieldPath.documentId, isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).where('isApproved' , isEqualTo: true) // Filter out the logged-in supplier
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading companies.'));
                  }

                  final companies = snapshot.data!.docs;

                  if (companies.isEmpty) {
                    return const Center(child: Text('No other companies found.'));
                  }

                  return ListView.builder(
                    itemCount: companies.length,
                    itemBuilder: (context, index) {
                      final company = companies[index];
                      return _buildCompanyCard(
                        context,
                        company['name'], // Dynamic name from Firebase
                        company['logo'], // Dynamic logo URL from Firebase
                        company.id, // Firebase document ID as companyId
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context, String companyName, String logoUrl, String companyId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EquipmentDetailScreen(
              companyId: companyId,
              companyName: companyName,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                logoUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay with company name
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                companyName,
                style: const TextStyle(
                  fontSize: 24, // Increased font size for better visibility
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
