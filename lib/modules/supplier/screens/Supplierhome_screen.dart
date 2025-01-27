import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:smartagri/modules/farmer/screens/add_banner_screen.dart';
import 'package:smartagri/modules/supplier/screens/AddEquipment_screen.dart';
import 'package:smartagri/modules/supplier/screens/SupplierEquipment_Details_screen.dart';

import 'package:smartagri/modules/supplier/screens/custom_supplier_screen.dart';

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
      drawer:CustomDrawer()  // Drawer
         
,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text('Add machinary',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              
                onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddEquipmentscreen()), // Navigate to AddEquipmentScreen
                                  );
                },
              ),
            ),


            Expanded(
              child: ElevatedButton(
                child: Text('Add banner' ,style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              
                onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddBannerScreen()), // Navigate to AddEquipmentScreen
                                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading:  Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer using the Builder context
              },
            );
          },
        ),
        title: Text(
          'Smart Agri',
          style: TextStyle(
            color: Color.fromRGBO(4, 75, 4, 0.961),
            fontFamily: 'Dancing Script',
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
         
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     height: 300,
                  //     autoPlay: true,
                  //     enlargeCenterPage: true, // Enlarge the center item
                  //     aspectRatio: 2.0, // Aspect ratio to stretch the images
                  //     onPageChanged: (index, reason) {
                  //       setState(() {
                  //         _currentIndex = index; // Update current index
                  //       });
                  //     },
                  //   ),
                  //   items: imgList
                  //       .map((item) => Container(
                  //             width: MediaQuery.of(context)
                  //                 .size
                  //                 .width, // Set width to full

                  //             child: Center(
                  //               child: Image.network(
                  //                 item,
                  //                 fit: BoxFit
                  //                     .cover, // Optional: Use BoxFit to cover the container
                  //                 height: 300, // Height of the image
                  //                 width: double.infinity,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  // ),

                  // Indicators
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: imgList.asMap().entries.map((entry) {
                  //     return GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _currentIndex = entry.key; // Update index on tap
                  //         });
                  //       },
                  //       child: Container(
                  //         width: 8.0,
                  //         height: 8.0,
                  //         margin: EdgeInsets.symmetric(horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: (Colors.black.withOpacity(
                  //               _currentIndex == entry.key ? 0.9 : 0.4)),
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // This will space the title and Add button apart
                      children: [],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Heading for Available for Rent Section
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'AVAILABLE MACHINES',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),

                  // List of Cards for Available Equipments

                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('machinary')
                       // .where('availability', isEqualTo: "Available" )
                        .where('userid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      } else {
                        var dataDoc = snapshot.data!.docs;
                        return dataDoc.isEmpty
                            ? Center(
                                child: Text(
                                  'No items available',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: dataDoc.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SupplierEquipmentDetailsScreen(
                                            id: dataDoc[index].id,
                                            name: dataDoc[index]['name']!,
                                            imageUrl: dataDoc[index]['image']!,
                                            rentRate: dataDoc[index]['price']
                                                .toString(),
                                            description: dataDoc[index]
                                                ['description']!,
                                            quantity: int.parse(
                                                dataDoc[index]['Quantity'].toString()),
                                            farmersOrders: [],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        elevation: 8.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.teal,
                                                Colors.blueAccent
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Equipment Image
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.network(
                                                  dataDoc[index]['image']!,
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              // Equipment Details
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      dataDoc[index]['name']!,
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                       
                                                      
                                                        Text(
                                                          'Rent Rate: ₹${dataDoc[index]['price'].toString()}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .yellowAccent,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      'Available Quantity: ${dataDoc[index]['Quantity']}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white70,
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

                  // Heading for Not Available for Rent Section
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'BOOKED',
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('machinary')
                        
                  //       .where('availability', isEqualTo: "Not Available" )
                  //       .where('Quantity', isEqualTo: 0)
                  //       .where('userid',
                  //           isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(child: CircularProgressIndicator());
                  //     } else if (snapshot.hasError) {
                  //       return Center(
                  //         child: Text(
                  //           'No valid data',
                  //           style: TextStyle(fontSize: 16, color: Colors.red),
                  //         ),
                  //       );
                  //     } else {
                  //       var dataDoc = snapshot.data!.docs;

                  //       return dataDoc.isEmpty
                  //           ? Center(
                  //               child: Text(
                  //                 'No items',
                  //                 style: TextStyle(
                  //                     fontSize: 18, color: Colors.grey),
                  //               ),
                  //             )
                  //           : ListView.builder(
                  //               shrinkWrap: true,
                  //               physics: NeverScrollableScrollPhysics(),
                  //               itemCount: dataDoc.length,
                  //               itemBuilder: (context, index) {
                  //                 return GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             SupplierEquipmentDetailsScreen(
                  //                           id: dataDoc[index].id,
                  //                           name: dataDoc[index]['name']!,
                  //                           imageUrl: dataDoc[index]['image']!,
                  //                           rentRate: dataDoc[index]['price']
                  //                               .toString(),
                  //                           description: dataDoc[index]
                  //                               ['description']!,
                  //                           quantity:
                  //                               dataDoc[index]['Quantity'],
                  //                           farmersOrders: [],
                  //                         ),
                  //                       ),
                  //                     );
                  //                   },
                  //                   child: Container(
                  //                     margin: EdgeInsets.symmetric(
                  //                         vertical: 10, horizontal: 15),
                  //                     child: Card(
                  //                       elevation: 6.0,
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(15.0),
                  //                       ),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           gradient: LinearGradient(
                  //                             colors: [
                  //                               Colors.purpleAccent,
                  //                               Colors.blue
                  //                             ],
                  //                             begin: Alignment.topLeft,
                  //                             end: Alignment.bottomRight,
                  //                           ),
                  //                           borderRadius:
                  //                               BorderRadius.circular(15.0),
                  //                           boxShadow: [
                  //                             BoxShadow(
                  //                               color: Colors.black12,
                  //                               blurRadius: 8.0,
                  //                               offset: Offset(2, 4),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         padding: const EdgeInsets.all(12.0),
                  //                         child: Row(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.center,
                  //                           children: [
                  //                             // Equipment Image
                  //                             ClipRRect(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(12.0),
                  //                               child: Image.network(
                  //                                 dataDoc[index]['image']!,
                  //                                 height: 100,
                  //                                 width: 100,
                  //                                 fit: BoxFit.cover,
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                                 width:
                  //                                     16), // Space between image and text
                  //                             // Equipment Details
                  //                             Expanded(
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   Text(
                  //                                     dataDoc[index]['name']!,
                  //                                     style: TextStyle(
                  //                                       fontSize: 20,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                       color: Colors.white,
                  //                                     ),
                  //                                   ),
                  //                                   SizedBox(height: 5),
                  //                                   Text(
                  //                                     'Rent Rate: ₹${dataDoc[index]['price'].toString()}',
                  //                                     style: TextStyle(
                  //                                       fontSize: 16,
                  //                                       color:
                  //                                           Colors.yellowAccent,
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //             );
                  //     }
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
