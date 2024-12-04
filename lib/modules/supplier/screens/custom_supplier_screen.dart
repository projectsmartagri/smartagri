import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/choose_screen.dart';
import 'package:smartagri/modules/supplier/screens/OtherCompaniesScreen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierProfile_Screen.dart';
import 'package:smartagri/modules/supplier/screens/Supplier_bookingdetails_screen.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class CustomDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the supplier's profile image from Firestore
  Future<String?> _getProfileImageUrl() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot supplierDoc = await _firestore
          .collection('suppliers')
          .doc(user.uid)
          .get();

      if (supplierDoc.exists) {
        return supplierDoc['logo']; // Assuming 'logo' field stores the image URL
      }
    }
    return null; // Return null if no image is found
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Custom Drawer Header
          FutureBuilder<String?>(
            future: _getProfileImageUrl(),
            builder: (context, snapshot) {
              String? profileImageUrl = snapshot.data;

              return DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 4, 156, 40),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: profileImageUrl != null
                          ? NetworkImage(profileImageUrl)
                          : AssetImage('assets/images/profile_picture.png')
                              as ImageProvider, // Default image if no URL is available
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome, Supplier!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Menu Items with Icons
          ListTile(
            leading: Icon(Icons.home, color: Colors.green),
            title: Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book, color: Colors.green),
            title: Text('Booking Details', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupplierBookingDetailsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.business, color: Colors.green),
            title: Text('Other Companies', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtherCompaniesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text('Profile', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupplierProfileScreen()),
              );
            },
          ),

          const Divider(),

          // Log Out Button with distinct style
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text(
              'LOG OUT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            onTap: () async {
              await _auth.signOut(); // Firebase sign out
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChooseScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
