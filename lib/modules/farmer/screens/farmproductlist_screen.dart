import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/addproduct_screen.dart';
import 'package:smartagri/modules/farmer/screens/farmequipmentdetails.dart';
import 'package:smartagri/modules/farmer/widgets/list_cardwidgets.dart';
import 'package:smartagri/modules/user/widgets/homescreenCustomwidget2.dart';

class FarmProductListScreen extends StatelessWidget {
  FarmProductListScreen({super.key});

  List<Map<String, dynamic>> list = [
    {
      'image':
          'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
      'title': 'Tractor',
      'subtitle': '',
      'price': 550.00
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpGp3hVwLQzIQH4k8RvTR00bW6mJswUoE1HQ&s',
      'title': 'Brushcutter',
      'subtitle': '',
      'price': 280.00
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDmtBPvo3FVULESCy3-dW8K7KdDvBpZNSyOA&s',
      'title': 'Waterpump',
      'subtitle': '',
      'price': 300.00
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzIH_gELrvINTYx83EEJMEzOVdXKJfxw540A&s',
      'title': 'Cultivator',
      'subtitle': '',
      'price': 420.00
    },
    {
      'image':
          'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
      'title': 'Spade',
      'subtitle': '',
      'price': 48.00
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLE8cdJVd9MPC6Hwlae6BtQWZmUQfq6dftDA&s',
      'title': 'Combine',
      'subtitle': '',
      'price': 840.00
    }
  ];

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Added products',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff181725),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: .7,
                ),
                itemBuilder: (Buildcontext, int index) {
                  return ListCardWidgets(
                    val: list[index],
                    isCategories: true,
                    ontab: () {},
                    image: list[index]['image'],
                    title: list[index]['title'],
                    subtitle: list[index]['subtitle'],
                    price: list[index]['price'].toString(),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action when FAB is pressed (e.g., navigate to AddProductScreen)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        }, // Icon for the FAB
        backgroundColor: Colors.green,
        child: Icon(Icons.add), // Customize the FAB color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positioned at bottom right
    );
  }
}


