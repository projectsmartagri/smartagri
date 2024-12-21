import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/choose_screen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerEditProfile.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[800],
        title: const Text(
          'Farmer Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('farmers')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            final farmerData = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Card
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                farmerData['profileImageUrl'] ??
                                    'https://via.placeholder.com/150',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              farmerData['name'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Dedicated Agropreneur',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green[600],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: const Text('Farmer ID'),
                                    content: farmerData['farmerIdUrl'] != null
                                        ? Image.network(
                                            farmerData['farmerIdUrl'],
                                            fit: BoxFit.cover,
                                          )
                                        : const Text('No Farmer ID Available'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.badge,
                                color: Colors.white,
                              ),
                              label: const Text('View Farmer ID',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _sectionHeader('Personal Details', Colors.green),

                    Card(
                      color: Colors.white,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            _detailRow(Icons.email,
                                farmerData['email'] ?? 'Not available'),
                            Divider(
                              height: 25,
                              thickness: .5,
                              color: Colors.grey.shade300,
                              endIndent: 10,
                              indent: 10,
                            ),
                            _detailRow(Icons.phone,
                                farmerData['phone'] ?? 'Not available'),
                            Divider(
                              height: 25,
                              thickness: .5,
                              color: Colors.grey.shade300,
                              endIndent: 10,
                              indent: 10,
                            ),
                            _detailRow(Icons.location_on,
                                farmerData['location'] ?? 'Not available'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _sectionHeader('Farm Information', Colors.green),
                    Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.check_circle,
                                color: Colors.green),
                            title: Text(
                              farmerData['isApproved'] == true
                                  ? 'Approved'
                                  : 'Not Approved',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Divider(
                            height: 25,
                            thickness: .5,
                            color: Colors.grey.shade300,
                            endIndent: 10,
                            indent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () async {
                                bool confirmLogout = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Logout'),
                                      content: const Text(
                                          'Are you sure you want to log out?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text('Logout'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmLogout) {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChooseScreen()),
                                    (route) => false,
                                  );
                                }
                              },
                              child: _detailRow(Icons.logout, 'Log Out'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FarmerEditProfile(
                                    farmerId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: const Text('Edit Profile',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Farmer data not found'));
          }
        },
      ),
    );
  }

  Widget _sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 20,
            color: color,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
