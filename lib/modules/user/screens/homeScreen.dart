import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    'All', // All products
    'Fruits',
    'Vegetables',
    'Grains',
    'Cereals',
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
      Product(name: 'Tomato', imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTQvCg9Mub2HqzBhjpq72jMNr0c_jJZ-bmz08GHhCq2GF_ivqIJ'),
      Product(name: 'Onion', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw0myvN9d65xTuId6xx26JQDC106zRdbtZoQ&s'),
      Product(name: 'Grapes', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9Yb72sDI3ay8Zx49tyMDmhstuRKWy3N3wJQ&s'),
      Product(name: 'Apple', imageUrl: 'https://www.jiomart.com/images/product/original/590004487/apple-indian-6-pcs-pack-approx-750-g-950-g-product-images-o590004487-p590004487-0-202203170227.jpg?im=Resize=(420,420)'),
      Product(name: 'Orange', imageUrl: 'https://m.media-amazon.com/images/I/31vcKZnUpzL.jpg'),
       Product(name: 'Potato', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0eqkPvKnP9hdTDq01i9tZi_u5EJvkzcBRg&s'),
      Product(name: 'Cauliflower', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu9zKy6_MNdNjpVkaSXub6-NGE7Oxad4WqmQ&s'),
      Product(name: 'Cucumber', imageUrl: 'https://organicmandya.com/cdn/shop/files/Cucumber.jpg?v=1721383087&width=1024'),
      Product(name: 'Avacados', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg'),
      Product(name: 'Guava', imageUrl: 'https://specialtyproduce.com/sppics/17130.png'),
       Product(name: 'Cabbage', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWgRBeB_SsY1NbHIriVpXPd0K3Tr9YOD5evQ&s'),
      Product(name: 'Garlic', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbWy0HyqAPyeV2F6GnB0jxnS9Js5LLRruS0A&s'),
      Product(name: 'Beans', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmK6vLW_he9gNupBjz7pgLowe4EVMWXsNzZA&s'),
      Product(name: 'Carrot', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbjm8N6pW0euFA33rYzRZajobwS9k0XR8o8Q&s'),
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
      Product(name: 'Tomato', imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTQvCg9Mub2HqzBhjpq72jMNr0c_jJZ-bmz08GHhCq2GF_ivqIJ'),
      Product(name: 'Onion', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw0myvN9d65xTuId6xx26JQDC106zRdbtZoQ&s'),
      Product(name: 'Potato', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0eqkPvKnP9hdTDq01i9tZi_u5EJvkzcBRg&s'),
      Product(name: 'Cauliflower', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu9zKy6_MNdNjpVkaSXub6-NGE7Oxad4WqmQ&s'),
      Product(name: 'Cucumber', imageUrl: 'https://organicmandya.com/cdn/shop/files/Cucumber.jpg?v=1721383087&width=1024'),
      Product(name: 'Cabbage', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWgRBeB_SsY1NbHIriVpXPd0K3Tr9YOD5evQ&s'),
      Product(name: 'Garlic', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbWy0HyqAPyeV2F6GnB0jxnS9Js5LLRruS0A&s'),
      Product(name: 'Beans', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmK6vLW_he9gNupBjz7pgLowe4EVMWXsNzZA&s'),
      Product(name: 'Carrot', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbjm8N6pW0euFA33rYzRZajobwS9k0XR8o8Q&s'),
    ],
   
     'Seeds': [
       Product(name: 'Chia Seed', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlHlewKMgxGj47U6sox-rV7itf_HwDu38VuQ&s'),
      Product(name: 'Pumpkin Seed', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZy1GMZhrmqXNXf-4BrySLi3RdEA5879YNKQ&s'),
      Product(name: 'Sunflower Seed', imageUrl: 'https://royalfantasy.in/cdn/shop/products/Sun-Flower-Seeds-1.jpg?v=1627732329'),
      Product(name: 'Coriander Seed', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShxoIG_0t1q7e5wXFU-8hv1AVchCNfngZHgg&s'),
      Product(name: 'Cluster Beans Seed', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjAE5nYYzLGW_65zA3OpeBqxzbSiyytHctmQ&s'),
      
    ],
   
    
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.all(8),
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
            ? Colors.white
            : const Color.fromARGB(255, 34, 90, 4),
        backgroundColor: isSelected
            ? Colors.green
            : const Color.fromARGB(255, 186, 221, 189),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Text(label),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
      
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Text(product.name,
          style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold), 
          
          ),
          // Add more details if necessary
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
    
  Product({required this.name, required this.imageUrl});
}
