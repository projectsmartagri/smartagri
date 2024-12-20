
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'beveragesScreen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  List<Map<String,dynamic>> list =[
    {
      'image' : 'asset/images/fruits_veg.png',
      'text' : 'Fruits and \nVegetables',
      'color' : const Color(0xffF2F3F2)
    },
    {
      'image': 'asset/images/cookingOil.png',
      'text': 'Cooking Oil \nand Ghee',
      'color' : const Color(0xfff8a44cb2)
    },
    {
    'image' : 'asset/images/meat_fish.png',
    'text' : 'Meat & Fish',
      'color' : const Color(0xffF7A593)
    },
    {
      'image' : 'asset/images/bakery_snacks.png',
      'text' : 'Bakery & Snacks',
      'color' : const Color(0xffD3B0E0)
    },
    {
      'image' : 'asset/images/Dairy_eggs.png',
      'text' : 'Dairy & Eggs',
      'color' : const Color(0xffFDE598)
    },
    {
      'image' : 'asset/images/beverages.png',
      'text' : 'Beverages',
      'color' : const Color(0xffB7DFF5)
    },
    {
      'image' : 'asset/images/bakery_snacks.png',
      'text' : 'Bakery & Snacks',
      'color' : const Color(0xffD3B0E0)
    },
    {
      'image' : 'asset/images/cookingOil.png',
      'text' : 'Cooking Oil \nand Ghee',
      'color': const Color(0xfff8a44cb2)
    }
  ];

  void bvrg({required BuildContext context,required String category}){

    if(category == 'Beverages'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Beveragesscreen(),));

    }





    }


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          const SizedBox(
            height: 40,
          ),
          const Text('Find Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF2F3F2),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Store',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
         
                ],
              ),
        ));
  }
}
