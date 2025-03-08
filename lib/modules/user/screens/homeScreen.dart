import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartagri/modules/user/screens/List_itemsScreen.dart';
import 'package:smartagri/modules/user/screens/exploreScreen.dart';
import 'package:smartagri/modules/user/screens/product_custom_list_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All'; // Default selected category
  final int _selectedIndex = 0; // Default index for BottomNavigationBar

  final List<String> imgList = [
    'https://5.imimg.com/data5/SELLER/Default/2023/11/364648303/OR/VC/GX/186750549/jangeer-multicrop-thresher-500x500.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTL2wkfKp1i7WvvRbQkiLFmAyiNxctUXuWCQ&s',
    'https://media.licdn.com/dms/image/v2/D5612AQG8JZ0pQy8Dog/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1709282970844?e=2147483647&v=beta&t=EldBFEM6BXbZurlbMZBQbBhsPcrn9Y9TO0JDvXjg92o',
  ];

  final List<String> categories = [
    'All',
    'Fruits',
    'Vegetables',
    'Legumes',
    'Cereals',
    'Spices',
    'Dairy',
    'Seeds',
    'Other',
  ];

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: const Text(
                'Smart Agri',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Dancing Script',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 106, 23),
                ),
              ),
              actions: [
                 IconButton(
                  icon: const Icon(Icons.search_outlined, color: Color.fromARGB(255, 68, 69, 68)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExploreScreen()),
                    );
                  },
                ),
                // IconButton(
                //   icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 68, 69, 68)),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const NotificationScreen()),
                //     );
                //   },
                // ),
                
              ],
              
            ), // No AppBar for other screens
      body: _homeScreen()
     
    );
  }


  Widget _homeScreen() {

  return Column(
    children: [
     
      // CarouselSlider(
      //   options: CarouselOptions(
      //     height: 200.0,
      //     autoPlay: true,
      //     enlargeCenterPage: true,
      //     aspectRatio: 16 / 9,
      //     autoPlayCurve: Curves.fastOutSlowIn,
      //     enableInfiniteScroll: true,
      //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
      //     viewportFraction: 0.8,
      //   ),
      //   items: imgList
      //       .map((item) => Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.circular(8.0),
      //               child: Image.network(item, fit: BoxFit.cover),
      //             ),
      //           ))
      //       .toList(),
      // ),
      // // Sliding Category List
      Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CategoryButton(
                label: category,
                isSelected: _selectedCategory == category,
                onPressed: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            );
          },
        ),
      ),
      // Product Grid

      Expanded(child:  ProductGrid(cat: _selectedCategory,))
     
    
    
    
    
    ],
  );
}




}

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color.fromARGB(255, 6, 106, 23) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
        shape: const BeveledRectangleBorder(), // Rectangular buttons
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

// Product model class
class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl});
}


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('No new notifications'),
      ),
    );
  }
}
