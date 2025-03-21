import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProductScreen.dart';
import 'package:smartagri/modules/farmer/screens/addproduct_screen.dart';
import 'package:smartagri/modules/farmer/screens/farmer_product_list_screen.dart';
import 'package:smartagri/modules/farmer/screens/farmer_product_order_screen.dart';
import 'package:smartagri/modules/farmer/screens/farmer_sales_report.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categoriesList = [
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMcKnkjU6Flrtc-Vjd0uzSmNv68h-duaITvw&s',
        'title': 'Vegetables',
      },
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpX1Ut5eFtME_JjgpQhH89wDito-zZiVo4Kw&s',
        'title': 'Fruits',
      },
      {
        'image': 'https://as2.ftcdn.net/v2/jpg/03/97/86/81/1000_F_397868193_nUAOTup7Z8R4kijdaJ9BuCwVSi8LobpR.jpg',
        'title': 'Seeds',
      },
      {
        'image': 'https://img.freepik.com/premium-photo/legumes-white-isolated-background_982005-10433.jpg',
        'title': 'Legumes',
      },
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJN1RgS6FMWUIR-a20PgTHLNDBFUNrQ-O_kg&s',
        'title': ' Spices',
      },
      {
        'image': 'https://5.imimg.com/data5/SELLER/Default/2023/11/357769297/DS/IS/HE/201826002/cereal-grains.jpg',
        'title': 'Cereal crops',
      },
        {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQiN2FBaIiH6nUAGkEzRkDZui1eu9YKGxNyw&s',
        'title': 'Coconut Products',
      },
         {
        'image': 'https://img.freepik.com/free-photo/dairy-products_114579-8756.jpg',
        'title': 'Diary',
      },
         {
        'image': 'https://img.freepik.com/premium-photo/dark-green-background-clean-no-texture-no-noise-grunge-empty-blank-copy-space-mockup-seamless_941600-69755.jpg?semt=ais_hybrid',
        'title': 'Other',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Farmer Dashboard",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           

            // Dashboard Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardCard(
                  title: "Product Sales",
                  icon: Icons.store,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductSalesScreen()),
                    );
                  },
                ),
                DashboardCard(
                  title: "Orders",
                  icon: Icons.shopping_cart,
                  onTap: () {

                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  FarmerProductOrdersScreen(farmerId:FirebaseAuth.instance.currentUser!.uid)),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Product Categories
            const Text(
              "Product Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                 child: Center( 
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: categoriesList.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductListScreen(cat: e['title']!)),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.network(
                                  e['image']!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                e['title']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.green[50],
        child: Container(
          width: 150,
          height: 100,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.green[700]),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


