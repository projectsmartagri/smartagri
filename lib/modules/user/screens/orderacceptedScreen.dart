import 'package:flutter/material.dart';
import 'package:smartagri/modules/user/screens/root_screen.dart';

import '../widgets/custombuttonWidget.dart';

import 'homeScreen.dart';

class Orderacceptedscreen extends StatelessWidget {
  const Orderacceptedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height:110 ,),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              alignment: Alignment.center,
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcoeYla6Yvdxsn2EUlpJZeXjqWVmlpxplkwKsftoS59lXzLBKDD48du4-VBTywI2mku_k&usqp=CAU',
              width: wt/1.52,
              height: ht/3.74,
              // alignment: Alignment.center,
                      ),
            ),
          ),

          Text('Your Order has been accepted',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ht/32.12,
            fontWeight: FontWeight.w600,
          )
          ),
          const SizedBox(height: 15,),
          
          const Text('Your item has been placed and is on \nits way to being processed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff7C7C7C)
          ),),

          const SizedBox(height: 90,),

          CustomButtonWidget(
  text: 'Back to Home',
  action: () {
    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserRootScreen()),
                    );
  },
),

          
         
      ],
      ),
    );
  }
}
