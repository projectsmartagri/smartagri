import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

    // List of equipment image URLs
    final List<String> equipmentList = [
      'https://5.imimg.com/data5/SELLER/Default/2023/11/364648303/OR/VC/GX/186750549/jangeer-multicrop-thresher-500x500.jpeg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTL2wkfKp1i7WvvRbQkiLFmAyiNxctUXuWCQ&s',
      'https://media.licdn.com/dms/image/v2/D5612AQG8JZ0pQy8Dog/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1709282970844?e=2147483647&v=beta&t=EldBFEM6BXbZurlbMZBQbBhsPcrn9Y9TO0JDvXjg92o',
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
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // You can navigate to the Home screen here if needed
                    },
                  ),
                    ListTile(
                   /* leading: Icon(Icons.details),*/
                    title: Text('Booking Details'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // You can navigate to the Home screen here if needed
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
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

                // First Row of Horizontal List of Cards for Equipments
                Container(
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: equipmentList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150.0,
                        margin: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              equipmentList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Second Row of Horizontal List of Cards for Equipments
                Container(
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: equipmentList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150.0,
                        margin: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              equipmentList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Other content below the equipment rows
                
              ],
            ),
          ),
        ],
      ),
    );
  }
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

// Placeholder for Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Settings Screen")),
    );
  }
}
