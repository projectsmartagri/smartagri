import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../widgets/custombuttonWidget.dart';

class Mycartscreen extends StatefulWidget {
  const Mycartscreen({super.key});

  @override
  State<Mycartscreen> createState() => _MycartscreenState();
}

class _MycartscreenState extends State<Mycartscreen> {
  Razorpay? _razorpay;
  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  double getTotalCost(List<dynamic> cartList) {
    double total = 0.0;
    for (var item in cartList) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final cartSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

    final orderData = cartSnapshot.docs.map((doc) => doc.data()).toList();

    await FirebaseFirestore.instance.collection('orders').add({
      'userId': user.uid,
      'items': orderData,
      'totalAmount': getTotalCost(orderData),
      'paymentId': response.paymentId,
      'isCompleted': true,
      'timestamp': FieldValue.serverTimestamp(),
    });

    for (var doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet: ${response.walletName}')),
    );
  }

  void _startPayment(double amount) {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    var options = {
      'key': 'rzp_test_QLvdqmBfoYL2Eu',
      'amount': (amount * 100).toInt(),
      'name': 'My Shop',
      'description': 'Order Payment',
      'prefill': {
        'contact': '1234567890',
        'email': 'user@example.com',
      },
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  var cartList;

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomSheet: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Loading indicator
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButtonWidget(
                text: 'Go To Checkout',
                action: () {
                  double totalCost = getTotalCost(cartList ?? []);
                  if (cartList == null || cartList.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your cart is empty!')),
                    );
                    return;
                  }
                  _startPayment(totalCost); // Trigger Razorpay payment
                },
              ),
            ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator()) // Full screen loading
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'My Cart',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff181725),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 5),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
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
                                      height: 100,
                                      width: 100,
                                    ),
                                    const SizedBox(width: 25),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartList[index]['name'],
                                          style: const TextStyle(
                                            color: Color(0xff181725),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance.currentUser?.uid)
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
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text('$itemCount'),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance.currentUser?.uid)
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth.instance.currentUser?.uid)
                                            .collection('cart')
                                            .doc(cartList[index].id)
                                            .delete();
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Color(0xffB3B3B3),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      '\$ ${totalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Color(0xff181725),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                                  const Divider(height: 5),
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
