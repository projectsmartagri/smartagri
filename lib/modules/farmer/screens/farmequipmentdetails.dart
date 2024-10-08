
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/addproduct_screen.dart';
import 'package:smartagri/modules/farmer/screens/addrentalorder_screen.dart';
import 'package:smartagri/modules/user/widgets/custombuttonWidget.dart';



class FarmEquipmentsDetails extends StatefulWidget {
  FarmEquipmentsDetails({super.key, required this.image, required this.title, required this.subtitle,required this.price, required this.value});

  final String image;
  final String title;
  final String subtitle;
  double price;
  Map<String,dynamic> value;

  @override
  State<FarmEquipmentsDetails> createState() => _FarmEquipmentsDetailsState();
}

class _FarmEquipmentsDetailsState extends State<FarmEquipmentsDetails> {
  int itemCount=0;
  bool isFavorite = false; // Track if the product is in favorites

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

    });
  }

  void initState() {

      

      print(isFavorite);

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: wt/0.99,
              height: ht/2.42,
              decoration: BoxDecoration(
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
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                        color: Color(0xff181725),
                        fontWeight: FontWeight.bold,
                        fontSize: ht/37.48
                      ),),
        
                     
                   
                   
                    ],
                  ),
        
        
        
                  Row(
                    children: [
                      Text(widget.subtitle,
                      style: TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),)
                    ],
                  ),
        
                  SizedBox(height: 25,),
        
                  Row(
                    children: [
                      // Image.asset('asset/images/-.png'),
        
                     
                      SizedBox(width: 15,),
        
                      Text('per hour'),
        
                      SizedBox(width: 15,),
        
                      // Image.asset('asset/images/+.png',),
        
                      
                    
                      Spacer(),

                        Text(
                         '₹${widget.price.toStringAsFixed(2)}',
                         textAlign: TextAlign.right,
                           style: TextStyle(
                             fontSize: ht/37.48,
                             fontWeight: FontWeight.bold
                           ),),
        
        
                     
                    ],
                  ),
        
                  SizedBox(height: 25,),
        
                  Divider(
                    height: 8,
                  ),
        
                  SizedBox(height: 10,),
        
                  Row(
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
        
                  SizedBox(height: 8),
        
                  Text('used for ploughing fields',
                  style: TextStyle(
                    color: Color(0xff7C7C7C),
                    fontSize: 13
                  ),),
        
                  SizedBox(height: 10,),
        
                  
                  SizedBox(height: 12),
        
                 
        
                  Divider(
                    height: 8,
                  ),
        
                  SizedBox(height: 10,),
        
                  Row(
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
        
                  SizedBox(height: 25,),
        
                  CustomButtonWidget(
                    text: 'Order',
      
                    action: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => DateFormScreen(),));
        
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
