import 'package:flutter/material.dart';

class Cardscreen extends StatelessWidget {
  const Cardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
        ),
          child: SizedBox(
            width: wt/2.37,
            height: ht/3.62,
            child:    Padding(
              padding: const EdgeInsets.symmetric(horizontal:12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25.21,width: 133.73,),

                  Image.asset('asset/images/banana.png',
                  width: wt/4.19,
                  height: ht/11.32,
                  ),

                  const SizedBox(height: 20,),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Organic Bananas',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff181725),
                      fontSize: 16
                    ),),
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('7pcs, Priceg',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff7C7C7C),
                      fontSize: 14
                    ),),
                  ),

                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('\$4.99',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff181725)
                      ),),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(47.67, 47.67),
                          backgroundColor: const Color(0xff53B175),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                          onPressed: (){

                          },
                          child: const Icon(Icons.add,
                          size: 17,
                          color: Colors.white,))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
