import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/OtherCompaniesScreen.dart';
import 'package:smartagri/modules/supplier/screens/Settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _drawerWidth = 0;

  void _toggleDrawer() {
    setState(() {
      _drawerWidth = _drawerWidth == 0 ? MediaQuery.of(context).size.width * 0.5 : 0;
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

    // List of equipment image URLs, names, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'Tractor',
        'imageUrl': 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
        'rentRate': '₹150/day',
      },
      {
        'name': 'Brushcutter',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_VM4opuy4P8FgJbXgL2bhJZvAvB7b9I1hJg&s',
        'rentRate': '₹150/hr',
      },
      {
        'name': 'Spade',
        'imageUrl': 'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
        'rentRate': '₹50/day',
      },
      {
        'name': 'Cultivator',
        'imageUrl': 'https://assets.tractorjunction.com/tractor-junction/assets/images/images/implementTractor/standard-duty-spring-type-36-1648717712.webp?format=webp', 
        'rentRate': '₹400/hr',
      },
      {
        'name': 'Waterpump',
        'imageUrl': 'https://www.spaark.in/cdn/shop/files/5-5-hp-diesel-engine-water-pump-3-inch-1.jpg?v=1716409998', 
        'rentRate': '₹100/hr',
      },
      {
        'name': 'Rotavator',
        'imageUrl': 'https://5.imimg.com/data5/DH/KW/MY-57495971/tractor-rotavator-500x500.jpg', 
        'rentRate': '₹600/hr',
      },
      {
        'name': 'Sprayer',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLI17EqaqJ8cJR-yjmLsbrRVSQQS-pyU6IA&s', 
        'rentRate': '₹200/hr',
      },
      {
        'name': 'Combine',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLE8cdJVd9MPC6Hwlae6BtQWZmUQfq6dftDA&s', 
        'rentRate': '₹800/hr',
      },
    ];

    // List for "Available for Rent" section
    final List<Map<String, String>> availableForRentList = [
      {
        'name': 'Tractor',
        'imageUrl': 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
        'rentRate': '₹150/day',
      },
      {
       'name': 'Spade',
        'imageUrl': 'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
        'rentRate': '₹50/day',
      },
      {
         'name': 'Cultivator',
        'imageUrl': 'https://assets.tractorjunction.com/tractor-junction/assets/images/images/implementTractor/standard-duty-spring-type-36-1648717712.webp?format=webp', 
        'rentRate': '₹400/hr',
      },
       {
        'name': 'Rotavator',
        'imageUrl': 'https://5.imimg.com/data5/DH/KW/MY-57495971/tractor-rotavator-500x500.jpg', 
        'rentRate': '₹600/hr',
      },
       {
        'name': 'Sprayer',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLI17EqaqJ8cJR-yjmLsbrRVSQQS-pyU6IA&s', 
        'rentRate': '₹200/hr',
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
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
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
                  //  leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context); 
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );// Close the drawer
                    },
                  ),
                  ListTile(
                    title: Text('Booking Details'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                   ListTile(
                   
                    title: Text('Other Companies'),
                    onTap: () {
                      Navigator.pop(context);
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OtherCompaniesScreen()),
                      
                      ); // Close the drawer
                       
                    },
                  ),
                   ListTile(
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );*/
                    },
                  ),
                  ListTile(
                   // leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
                      Navigator.pop(context); // Close the drawer
                      // Add your log out logic here, e.g., navigate to login screen
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Sliding Advertisement Images
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                    ),
                    items: imgList.map((item) => Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      ),
                    )).toList(),
                  ),

                  // Heading for Equipments
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'EQUIPMENTS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Vertical List of Cards for Equipments
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: equipmentList.length,
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
                                    equipmentList[index]['imageUrl']!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16), // Add space between image and text
                                // Equipment Name and Rent Rate
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        equipmentList[index]['name']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Rent Rate: ${equipmentList[index]['rentRate']}',
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

                  // List of Cards for Available for Rent Equipments
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
                                SizedBox(width: 16), // Add space between image and text
                                // Equipment Name and Rent Rate
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class ProfileScreen {
  const ProfileScreen();
}

// Placeholder for Notification Screen
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(child: Text("Notification Screen")),
    );
  }
}
