import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Agri',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All'; // Default selected category

  final List<String> imgList = [
    'https://5.imimg.com/data5/SELLER/Default/2023/11/364648303/OR/VC/GX/186750549/jangeer-multicrop-thresher-500x500.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTL2wkfKp1i7WvvRbQkiLFmAyiNxctUXuWCQ&s',
    'https://media.licdn.com/dms/image/v2/D5612AQG8JZ0pQy8Dog/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1709282970844?e=2147483647&v=beta&t=EldBFEM6BXbZurlbMZBQbBhsPcrn9Y9TO0JDvXjg92o',
  ];

  final List<String> categories = [
    'All',   // All products
    'Fruits',
    'Vegetables',
    'Grains',
    'cereals',
    'Spices',
    'Medicinal Plants',
    'Organic Products',
    'Dairy',
    'Poultry',
    'Seeds',
    'Fertilizers'
  ];

  final Map<String, List<Product>> products = {
    'All': [
      Product(name: 'Grapes', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9Yb72sDI3ay8Zx49tyMDmhstuRKWy3N3wJQ&s'),
      Product(name: 'Apple', imageUrl: 'https://www.jiomart.com/images/product/original/590004487/apple-indian-6-pcs-pack-approx-750-g-950-g-product-images-o590004487-p590004487-0-202203170227.jpg?im=Resize=(420,420)'),
      Product(name: 'Orange', imageUrl: 'https://m.media-amazon.com/images/I/31vcKZnUpzL.jpg'),
      Product(name: 'Avacados', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg'),
      Product(name: 'Guava', imageUrl: 'https://specialtyproduce.com/sppics/17130.png'),
      Product(name: 'Papaya', imageUrl: 'https://cdn.shopaccino.com/rootz/products/picture1-798125_m.jpg?v=488'),
      Product(name: 'Sapota', imageUrl: 'https://5.imimg.com/data5/SELLER/Default/2023/10/357307036/UG/NN/TM/193586530/sapota-fruits.jpeg'),
      Product(name: 'Watermelon', imageUrl: 'https://organicmandya.com/cdn/shop/files/Watermelon.jpg?v=1721378496&width=1000'),
    ],

     'Fruits': [
      Product(name: 'Grapes', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9Yb72sDI3ay8Zx49tyMDmhstuRKWy3N3wJQ&s'),
      Product(name: 'Apple', imageUrl: 'https://www.jiomart.com/images/product/original/590004487/apple-indian-6-pcs-pack-approx-750-g-950-g-product-images-o590004487-p590004487-0-202203170227.jpg?im=Resize=(420,420)'),
      Product(name: 'Orange', imageUrl: 'https://m.media-amazon.com/images/I/31vcKZnUpzL.jpg'),
      Product(name: 'Avacados', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg'),
      Product(name: 'Guava', imageUrl: 'https://specialtyproduce.com/sppics/17130.png'),
      Product(name: 'Papaya', imageUrl: 'https://cdn.shopaccino.com/rootz/products/picture1-798125_m.jpg?v=488'),
      Product(name: 'Sapota', imageUrl: 'https://5.imimg.com/data5/SELLER/Default/2023/10/357307036/UG/NN/TM/193586530/sapota-fruits.jpeg'),
      Product(name: 'Watermelon', imageUrl: 'https://organicmandya.com/cdn/shop/files/Watermelon.jpg?v=1721378496&width=1000'),
      ],
   
   
    'Vegetables': [
      Product(name: 'Grapes', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9Yb72sDI3ay8Zx49tyMDmhstuRKWy3N3wJQ&s'),
      Product(name: 'Apple', imageUrl: 'https://www.jiomart.com/images/product/original/590004487/apple-indian-6-pcs-pack-approx-750-g-950-g-product-images-o590004487-p590004487-0-202203170227.jpg?im=Resize=(420,420)'),
      Product(name: 'Orange', imageUrl: 'https://m.media-amazon.com/images/I/31vcKZnUpzL.jpg'),
      Product(name: 'Avacados', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg'),
      Product(name: 'Guava', imageUrl: 'https://specialtyproduce.com/sppics/17130.png'),
      Product(name: 'Papaya', imageUrl: 'https://cdn.shopaccino.com/rootz/products/picture1-798125_m.jpg?v=488'),
      Product(name: 'Sapota', imageUrl: 'https://5.imimg.com/data5/SELLER/Default/2023/10/357307036/UG/NN/TM/193586530/sapota-fruits.jpeg'),
      Product(name: 'Watermelon', imageUrl: 'https://organicmandya.com/cdn/shop/files/Watermelon.jpg?v=1721378496&width=1000'),
    ],
   
   
    'Grains': [
      Product(name: 'Grapes', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9Yb72sDI3ay8Zx49tyMDmhstuRKWy3N3wJQ&s'),
      Product(name: 'Apple', imageUrl: 'https://www.jiomart.com/images/product/original/590004487/apple-indian-6-pcs-pack-approx-750-g-950-g-product-images-o590004487-p590004487-0-202203170227.jpg?im=Resize=(420,420)'),
      Product(name: 'Orange', imageUrl: 'https://m.media-amazon.com/images/I/31vcKZnUpzL.jpg'),
      Product(name: 'Avacados', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg'),
      Product(name: 'Guava', imageUrl: 'https://specialtyproduce.com/sppics/17130.png'),
      Product(name: 'Papaya', imageUrl: 'https://cdn.shopaccino.com/rootz/products/picture1-798125_m.jpg?v=488'),
      Product(name: 'Sapota', imageUrl: 'https://5.imimg.com/data5/SELLER/Default/2023/10/357307036/UG/NN/TM/193586530/sapota-fruits.jpeg'),
      Product(name: 'Watermelon', imageUrl: 'https://organicmandya.com/cdn/shop/files/Watermelon.jpg?v=1721378496&width=1000'),
    ],
   
   
    'Cereals': [Product(name: 'Cereal 1', imageUrl: 'https://via.placeholder.com/100/0000FF/FFFFFF?text=Cereal+1')],
    
    
    'Spices': [Product(name: 'Spice 1', imageUrl: 'https://via.placeholder.com/100/FF0000/FFFFFF?text=Spice+1')],
    
    
    
   
    'Medicinal Plants': [Product(name: 'Plant 1', imageUrl: 'https://via.placeholder.com/100/00FF00/FFFFFF?text=Plant+1')],
   
   
    'Organic Products': [Product(name: 'Organic Product 1', imageUrl: 'https://via.placeholder.com/100/000000/FFFFFF?text=Organic+1')],
   
   
   
   
   
    
   
   
    'Dairy': [Product(name: 'Dairy Product 1', imageUrl: 'https://via.placeholder.com/100/00AAFF/FFFFFF?text=Dairy+1')],
   
   
    'Poultry': [Product(name: 'Poultry Product 1', imageUrl: 'https://via.placeholder.com/100/AAAAAA/FFFFFF?text=Poultry+1')],
   
   
    'Seeds': [Product(name: 'Seed 1', imageUrl: 'https://via.placeholder.com/100/FFAAAA/FFFFFF?text=Seed+1')],
   
   
    'Fertilizers': [Product(name: 'Fertilizer 1', imageUrl: 'https://via.placeholder.com/100/00FFAA/FFFFFF?text=Fertilizer+1')],
  
  
  };
  @override
  Widget build(BuildContext context) {
    List<Product> displayedProducts = products[_selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Smart Agri',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Dancing Script',
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 6, 106, 23),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: const Color.fromARGB(255, 68, 69, 68)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 239, 234, 234),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Search here...',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),

          // Advertisement Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: imgList.map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(item, fit: BoxFit.cover),
              ),
            )).toList(),
          ),

          // Sliding Category List
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
                        _selectedCategory = category; // Set selected category
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Displaying products based on selected category
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              padding: EdgeInsets.all(8),
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: displayedProducts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(
          'No new notifications',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected
            ? const Color.fromARGB(255, 252, 250, 250)
            : const Color.fromARGB(255, 231, 229, 229),
        backgroundColor: isSelected ? Colors.green : const Color.fromARGB(255, 72, 72, 72),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(label),
    );
  }
}

// Product class to hold product data
class Product {
  final String name;

  Product({required this.name, required String imageUrl});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('https://via.placeholder.com/100', height: 60),
          Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
