import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/AddEquipment_screen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierEquipment_Details_screen.dart';
import 'package:smartagri/modules/supplier/screens/OtherCompaniesScreen.dart';
import 'package:smartagri/modules/supplier/screens/Settings_screen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierLoginScreen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierProfile_Screen.dart';
import 'package:smartagri/modules/supplier/screens/Supplier_bookingdetails_screen.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  _SupplierHomeScreenState createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  double _drawerWidth = 0;
  int _currentIndex = 0; // To track the current index of the carousel

  void _toggleDrawer() {
    setState(() {
      _drawerWidth =
          _drawerWidth == 0 ? MediaQuery.of(context).size.width * 0.5 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of advertisement image URLs

    final List<String> imgList = [
      'https://5.imimg.com/data5/SELLER/Default/2023/11/364648303/OR/VC/GX/186750549/jangeer-multicrop-thresher-500x500.jpeg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTL2wkfKp1i7WvvRbQkiLFmAyiNxctUXuWCQ&s',
      'https://media.licdn.com/dms/image/v2/D5612AQG8JZ0pQy8Dog/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1709282970844?e=2147483647&v=beta&t=EldBFEM6BXbZurlbMZBQbBhsPcrn9Y9TO0JDvXjg92o',
    ];

    // List for "Available for Rent" section
    final List<Map<String, String>> availableForRentList = [
      {
        'name': 'Tractor',
        'imageUrl':
            'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
        'rentRate': '₹150/day',
      },
      {
        'name': 'Spade',
        'imageUrl':
            'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
        'rentRate': '₹50/day',
      },
      {
        'name': 'Cultivator',
        'imageUrl':
            'https://assets.tractorjunction.com/tractor-junction/assets/images/images/implementTractor/standard-duty-spring-type-36-1648717712.webp?format=webp',
        'rentRate': '₹400/hr',
      },
      {
        'name': 'Rotavator',
        'imageUrl':
            'https://5.imimg.com/data5/DH/KW/MY-57495971/tractor-rotavator-500x500.jpg',
        'rentRate': '₹600/hr',
      },
      {
        'name': 'Sprayer',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLI17EqaqJ8cJR-yjmLsbrRVSQQS-pyU6IA&s',
        'rentRate': '₹200/hr',
      },
    ];

    // List for "Not Available" section with availability status
    final List<Map<String, String>> notAvailableList = [
      {
        'name': 'Brushcutter',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_VM4opuy4P8FgJbXgL2bhJZvAvB7b9I1hJg&s',
        'rentRate': '₹150/hr',
        'availabilityStatus': 'Out of Stock',
      },
      {
        'name': 'Waterpump',
        'imageUrl':
            'https://www.spaark.in/cdn/shop/files/5-5-hp-diesel-engine-water-pump-3-inch-1.jpg?v=1716409998',
        'rentRate': '₹100/hr',
        'availabilityStatus': 'Under Maintenance',
      },
      {
        'name': 'Combine',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLE8cdJVd9MPC6Hwlae6BtQWZmUQfq6dftDA&s',
        'rentRate': '₹800/hr',
        'availabilityStatus': 'Temporarily Unavailable',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleDrawer,
        ),
        title: Text(
          'Smart Agri',
          style: TextStyle(
            fontFamily: 'Dancing Script',
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Drawer
          AnimatedContainer(
            width: _drawerWidth,
            duration: const Duration(milliseconds: 300),
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 156, 40),
                    ),
                    child: Container(), // Empty container instead of text
                  ),
                  ListTile(
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SupplierHomeScreen()),
                      ); // Close the drawer
                    },
                  ),
                  ListTile(
                    title: Text('Booking Details'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SupplierBookingDetailsScreen()),
                      ); // Close the drawer
                    },
                  ),
                  ListTile(
                    title: Text('Other Companies'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtherCompaniesScreen()),
                      ); // Close the drawer
                    },
                  ),
                  ListTile(
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SupplierProfileScreen()),
                      ); // Close the drawer
                    },
                  ),
                  ListTile(
                    // leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                  const Divider(), // Divider before LOG OUT
                  ListTile(
                    title: Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: Colors.red, // Change color to red for emphasis
                      ),
                    ),
                    onTap: () {
                      // Handle log out logic here
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SupplierLoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      enlargeCenterPage: true, // Enlarge the center item
                      aspectRatio: 2.0, // Aspect ratio to stretch the images
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index; // Update current index
                        });
                      },
                    ),
                    items: imgList
                        .map((item) => Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set width to full

                              child: Center(
                                child: Image.network(
                                  item,
                                  fit: BoxFit
                                      .cover, // Optional: Use BoxFit to cover the container
                                  height: 300, // Height of the image
                                  width: double.infinity,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = entry.key; // Update index on tap
                          });
                          // Navigate to the respective page
                          // You can uncomment this if needed
                          // CarouselSlider.of(context).animateToPage(entry.key);
                        },
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Colors.black.withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Heading for Equipments
                  // Heading for Equipments with Add Equipment Button
                  // Heading for Equipments with Add Equipment Button and Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // This will space the title and Add button apart
                      children: [
                        Text(
                          'ALL EQUIPMENTS',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Define what happens when the button or text is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddEquipmentscreen()), // Navigate to AddEquipmentScreen
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.green,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Inside the SupplierHomeScreen class, replace the ListView.builder for ALL EQUIPMENTS
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('machinary')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Somthing went wrong');
                      } else {
                        var dataDoc = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataDoc.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to EquipmentDetailsScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SupplierEquipmentDetailsScreen(
                                      name: dataDoc[index]['name']!,
                                      imageUrl: dataDoc[index]['image']!,
                                      rentRate:
                                          dataDoc[index]['price'].toString(),
                                      description: dataDoc[index]
                                          ['description']!,
                                      quantity: 2,
                                      farmersOrders: [],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 3.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        // Equipment Image on the left
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            dataDoc[index]['image']!!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                16), // Add space between image and text
                                        // Equipment Name and Rent Rate
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dataDoc[index]['name']!,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Rent Rate: ${dataDoc[index]['price'].toString()!}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Heading for Available for Rent Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'AVAILABLE FOR RENT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // List of Cards for Available Equipments
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: availableForRentList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Equipment Image on the left
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    availableForRentList[index]['imageUrl']!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        16), // Add space between image and text
                                // Equipment Name and Rent Rate
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        availableForRentList[index]['name']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rent Rate: ${availableForRentList[index]['rentRate']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Heading for Not Available for Rent Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'NOT AVAILABLE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // List of Cards for Not Available Equipments
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: notAvailableList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Equipment Image on the left
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    notAvailableList[index]['imageUrl']!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        16), // Add space between image and text
                                // Equipment Name, Rent Rate, and Availability Status
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notAvailableList[index]['name']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rent Rate: ${notAvailableList[index]['rentRate']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Status: ${notAvailableList[index]['availabilityStatus']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .red, // Highlight status in red
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder classes for Navigation (you may replace these with your actual implementations)
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Notifications')));
  }
}
