import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/add_to_cart.dart';
import '../widgets/custombuttonWidget.dart';

class Mycartscreen extends StatefulWidget {
  const Mycartscreen({super.key});

  @override
  State<Mycartscreen> createState() => _MycartscreenState();
}

class _MycartscreenState extends State<Mycartscreen> {
  double getTotalCost(List<dynamic> cartList) {
    double total = 0.0;
    for (var item in cartList) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  var cartList;

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButtonWidget(
                  text: 'Go To Checkout',
                  action: () {
                    double totalCost = getTotalCost(cartList?? []);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Checkout',
                                      style: TextStyle(
                                          fontSize: ht / 37.48,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.close),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(height: 5),
                                const SizedBox(height: 10),
                                // More checkout UI code here...
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'My Cart',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff181725),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid) // Replace 'userId' with the actual user ID
                    .collection('cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                   cartList = snapshot.data?.docs ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      int itemCount = cartList[index]['quantity'];
                      double itemPrice = cartList[index]['price'];
                      double totalPrice = itemPrice * itemCount;

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Image.network(
                                cartList[index]['imageUrl'],
                                height: 100, // Assuming you store the image URL in Firestore
                                width: 100,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartList[index]['name'],
                                    style: const TextStyle(
                                        color: Color(0xff181725),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Update quantity logic
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc('userId')
                                                .collection('cart')
                                                .doc(cartList[index].id)
                                                .update({
                                              'quantity': FieldValue.increment(-1),
                                            });
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: Color(0xffB3B3B3),
                                            size: 20,
                                          )),
                                      const SizedBox(width: 15),
                                      Container(
                                        height: ht / 22.48,
                                        width: wt / 10.29,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black12),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text('$itemCount'),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      InkWell(
                                          onTap: () {
                                            // Update quantity logic
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc('userId')
                                                .collection('cart')
                                                .doc(cartList[index].id)
                                                .update({
                                              'quantity': FieldValue.increment(1),
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Remove item logic
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc('userId')
                                          .collection('cart')
                                          .doc(cartList[index].id)
                                          .delete();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Color(0xffB3B3B3),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    '\$ ${totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        color: Color(0xff181725),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ]),
                            const SizedBox(height: 15),
                            const Divider(
                              height: 5,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              
             
           
           
            ],
          ),
        ),
      ),
    );
  }
}
