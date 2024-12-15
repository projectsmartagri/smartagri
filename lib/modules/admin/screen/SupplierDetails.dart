import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupplierDetails extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String companyLicenseUrl;
  final bool isApproved; // Added status field to determine if the supplier is pending or accepted

   SupplierDetails({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.companyLicenseUrl,
    required this.isApproved, // Passed the status field in the constructor
  });

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to update approval status
  Future<void> _updateSupplierStatus(String supplierId, bool isApproved) async {
    try {
      await _firestore.collection('suppliers').doc(supplierId).update({
        'isApproved': isApproved,
      });

      String statusMessage = isApproved ? 'Supplier Approved' : 'Supplier Rejected';
      print(statusMessage);

      // Move to another tab or show a snackbar
      // For now, we will just show a SnackBar
    } catch (e) {
      print('Error updating supplier: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Supplier Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 39, 156, 68),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Supplier Information',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 135, 74),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: Icons.business,
                        label: 'Company Name',
                        value: name,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: email,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: phone,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Address',
                        value: address,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Uploaded Company Document: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: companyLicenseUrl.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _showFullScreenImage(context, companyLicenseUrl);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    companyLicenseUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text(
                                        'Failed to load ID image.',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const Text(
                                'No document uploaded.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Only show the buttons if the status is "pending" (isApproved == false)
              if (!isApproved) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      context,
                      label: 'Approve',
                      icon: Icons.check,
                      color: const Color.fromARGB(255, 28, 168, 63),
                      onPressed: () async {
                        await _updateSupplierStatus('userid', true);  // Use actual supplier ID
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Supplier Approved')),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildActionButton(
                      context,
                      label: 'Reject',
                      icon: Icons.close,
                      color: Colors.red.shade600,
                      onPressed: () async {
                        await _updateSupplierStatus('userid', false);  // Use actual supplier ID
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Supplier Rejected')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build info rows with icon and label
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color.fromARGB(255, 27, 143, 38), size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Reusable action button for Approve and Reject
  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Show full screen image
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
