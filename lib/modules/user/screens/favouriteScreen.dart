import 'package:flutter/material.dart';
import '../services/add_to_cart.dart';
import '../services/add_to_favourites.dart';
import '../widgets/custombuttonWidget.dart';
import 'homeScreen.dart';
import 'mycartScreen.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back navigation
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: favList.length,
                itemBuilder: (context, index) {
                  print(favList);
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Image.network(favList[index]['image']),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                favList[index]['title'],
                                style: const TextStyle(
                                    color: Color(0xff181725),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    favList[index]['subtitle'],
                                    style: const TextStyle(
                                        color: Color(0xff7C7C7C), fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '\$ ${favList[index]['price'].toString()}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 5,
                      )
                    ]),
                  );
                },
              ),
            ),
            CustomButtonWidget(
              text: 'Add All To Cart',
              action: () {
                for (var favList in favList) {
                  addToCart(values: favList);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mycartscreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
