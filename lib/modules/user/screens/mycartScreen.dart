import 'package:flutter/material.dart';

import '../services/add_to_cart.dart';
import '../widgets/custombuttonWidget.dart';
import 'orderacceptedScreen.dart';

class Mycartscreen extends StatefulWidget {
  Mycartscreen({super.key});

  @override
  State<Mycartscreen> createState() => _MycartscreenState();
}

class _MycartscreenState extends State<Mycartscreen> {
  double getTotalCost() {
    double total = 0.0;
    for (var item in cartList) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Makes the screen scrollable
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
              ListView.builder(
                shrinkWrap: true, // Ensures that ListView takes up minimal space
                physics: NeverScrollableScrollPhysics(), // Prevents ListView from scrolling independently
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  int itemCount = cartList.elementAt(index)['quantity'];
                  double itemPrice = cartList.elementAt(index)['price'];
                  double totalPrice = itemPrice * itemCount;

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Image.asset(
                            cartList.elementAt(index)['image'],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartList.elementAt(index)['title'],
                                style: const TextStyle(
                                    color: Color(0xff181725),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cartList.elementAt(index)['subtitle'],
                                style: const TextStyle(
                                    color: Color(0xff7C7C7C), fontSize: 14),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          cartList.elementAt(index)['quantity']--;
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
                                        border: Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text('$itemCount'),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          cartList.elementAt(index)['quantity']++;
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
                              const Icon(
                                Icons.close,
                                color: Color(0xffB3B3B3),
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
              ),
              CustomButtonWidget(
                text: 'Go To Checkout',
                action: () {
                  double totalCost = getTotalCost();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
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
                              Row(
                                children: const [
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                        color: Color(0xff7C7C7C), fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Select Method',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 5),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    'Payment',
                                    style: TextStyle(
                                        color: Color(0xff7C7C7C), fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 5),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    'Promo Code',
                                    style: TextStyle(
                                        color: Color(0xff7C7C7C), fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Pick Discount',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 5),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    'Total cost',
                                    style: TextStyle(
                                        color: Color(0xff7C7C7C), fontSize: 18),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\$${totalCost.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 5),
                              const SizedBox(height: 10),
                              RichText(
                                text: const TextSpan(
                                  text: 'By placing an order you agree to our ',
                                  style: TextStyle(
                                      color: Color(0xff7C7C7C), fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: 'Terms ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'and ',
                                      style: TextStyle(
                                          color: Color(0xff7C7C7C), fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Conditions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomButtonWidget(
                                text: 'Place Order',
                                action: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Orderacceptedscreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
