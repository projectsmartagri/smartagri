import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails extends StatefulWidget {
  final String userId; // User ID to fetch details

  const UserDetails({super.key, required this.userId});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String name = '';
  String email = '';
  String phone = '';
  String address = ''; // Address field

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'] ?? 'N/A';
          email = userDoc['email'] ?? 'N/A';
          phone = userDoc['phone'] ?? 'N/A';
          address = userDoc['address'] ?? 'N/A'; // Fetch address
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF0F0F0), // Light background color
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'User Information',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              // User Details Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfoRow(Icons.person, 'Name', name),
                      const SizedBox(height: 16),
                      _buildUserInfoRow(Icons.email, 'Email', email),
                      const SizedBox(height: 16),
                      _buildUserInfoRow(Icons.phone, 'Phone', phone),
                      const SizedBox(height: 16),
                      _buildMultilineRow(Icons.location_on, 'Address', address), // Address Field
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated layout to keep label and value on the same line (except address)
  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(icon, color: Colors.green, size: 24), // Icon for better UI
        const SizedBox(width: 10),
        Text(
          '$label: ', // Add colon for readability
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Special method for address, allowing multi-line wrapping
  Widget _buildMultilineRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns text at the top
      children: [
        Icon(icon, color: Colors.green, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(text: value), // Address will wrap automatically
              ],
            ),
          ),
        ),
      ],
    );
  }
}
