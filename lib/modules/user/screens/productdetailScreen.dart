
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import '../services/add_to_favourites.dart';
import '../widgets/custombuttonWidget.dart';
import 'mycartScreen.dart';

class Productdetailscreen extends StatefulWidget {
  Productdetailscreen({super.key, required this.image, required this.title, required this.subtitle,required this.price, required this.value});

  final String image;
  final String title;
  final String subtitle;
  double price;
  Map<String,dynamic> value;

  @override
  State<Productdetailscreen> createState() => _ProductdetailscreenState();
}

class _ProductdetailscreenState extends State<Productdetailscreen> {
  int itemCount=0;
  bool isFavorite = false; // Track if the product is in favorites

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

    });
  }

  @override
  void initState() {

      isFavorite =  favList.contains(widget.value);

      print(isFavorite);

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: wt/0.99,
              height: ht/2.42,
              decoration: const BoxDecoration(
                color: Color(0xffF2F3F2)
              ),
        
              // child: Image.asset(image,
              // alignment: Alignment.center,),
        
              child: CarouselSlider(
                  items: [
                    Image.network(widget.image)
                  ],
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
        
                    },
                    scrollDirection: Axis.horizontal,
                  )
              ),
            ),
        
        
        
        
        
        
        
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title,
                      style: TextStyle(
                        color: const Color(0xff181725),
                        fontWeight: FontWeight.bold,
                        fontSize: ht/37.48
                      ),),
        
                     
                    ],
                  ),
        
        
        
                  Row(
                    children: [
                      Text(widget.subtitle,
                      style: const TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),)
                    ],
                  ),
        
                  const SizedBox(height: 25,),
        
                  Row(
                    children: [
                      // Image.asset('asset/images/-.png'),
        
                      InkWell(
                          onTap: (){
                            setState(() {
                              if(itemCount>0) {
                                itemCount--;
                              }
                            });
            },
                          child: const Icon(
                            Icons.remove,
                            color: Color(0xffB3B3B3),
                            size: 20,
                          )),
        
                      const SizedBox(width: 15,),
        
                      Container(
                        height: ht/22.48,
                        width: wt/10.29,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12
                          ),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text('$itemCount'),
                        ),
                      ),
        
                      const SizedBox(width: 15,),
        
                      // Image.asset('asset/images/+.png',),
        
                      InkWell(
                          onTap: () {
                            setState(() {
                              itemCount++;
                            });
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 20,
                          )),
        
        
                      const Spacer(),
        
                      Text('\$${widget.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: ht/37.48,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
        
                  const SizedBox(height: 25,),
        
                  const Divider(
                    height: 8,
                  ),
        
                  const SizedBox(height: 10,),
        
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Detail',
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),),
        
                      Icon(Icons.keyboard_arrow_down_sharp)
                    ],
                  ),
        
                  const SizedBox(height: 8),
        
                  const Text('Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.',
                  style: TextStyle(
                    color: Color(0xff7C7C7C),
                    fontSize: 13
                  ),),
        
                  const SizedBox(height: 10,),
        
                  const Divider(
                    height:8
                  ),
        
                  const SizedBox(height: 12),
        
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nutritions',
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),),
                      const Spacer(),
        
                      Container(
                        height: ht/44.97,
                        width: wt/11.75,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff7C7C7C)
                            ),
                            color: const Color(0xff7C7C7C),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(
                          child: Text('100 gr',
                          style: TextStyle(
                            fontSize: 9
                          ),),
        
                        ),
                      ),
        
                      const SizedBox(width: 10,),
        
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
        
                  const SizedBox(height: 10,),
        
                  const Divider(
                    height: 8,
                  ),
        
                  const SizedBox(height: 10,),
        
                  const Row(
                    children: [
                      Text('Review',
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),),
        
                      Spacer(),
        
                      Row(
                        children: [
                          Icon(Icons.star,
                          color: Color(0xffF3603F),),
        
                          Icon(Icons.star,
                            color: Color(0xffF3603F),),
        
                          Icon(Icons.star,
                            color: Color(0xffF3603F),),
        
                          Icon(Icons.star,
                            color: Color(0xffF3603F),),
        
                          Icon(Icons.star,
                            color: Color(0xffF3603F),),
        
                        ],
                      ),
        
                      SizedBox(width: 10,),
        
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  ),
        
                  const SizedBox(height: 25,),
        
                  CustomButtonWidget(
                    text: 'Add To Basket',
                    action: () {
        
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Mycartscreen(),));
                    },
                  ),
                ],
              ),
            )
        
        
        
        
          ],
        ),
      ),


    );
  }
}
