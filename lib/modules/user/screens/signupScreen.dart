import 'package:flutter/material.dart';

import 'homeScreen.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              SizedBox(height: 60,),
          
              Image.asset('asset/images/carrot_color.png'),
          
              SizedBox(height: 60,),
          
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign Up',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff181725),
                          fontSize: ht/34.59,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
          
                  SizedBox(height: 20,),
          
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter your credentials to continue',
                      style: TextStyle(
                          color: Color(0xff7C7C7C),
                          fontSize: 16
                      ),),
                  ),
          
                  SizedBox(height: 35,),
          
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Username'
                    ),
                  ),
          
                  SizedBox(height: 35,),
          
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Email'
                    ),
                  ),
          
                  SizedBox(height: 35,),
          
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off_outlined)
                    ),
                  ),
          
                  SizedBox(height: 20,),
          
                  RichText(text: TextSpan(
                    text: 'By continuing you agree to our ',style: TextStyle(color: Colors.black12,fontSize: 14),
                    children:[
                      TextSpan(text: 'Terms of Service ',style: TextStyle(color: Colors.green,fontSize: 14)),
                      TextSpan(text: 'and ',style: TextStyle(color: Colors.black12,fontSize: 14)),
                      TextSpan(text: 'Privacy Policy ',style: TextStyle(color: Colors.green,fontSize: 14))
                    ]
                  )),
          
          
                  SizedBox(height: 30,),
          
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        fixedSize: Size(364, 67),
                        backgroundColor: Color(0xff53B175),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Homescreen(),));
          
                      },
                      child: Text('Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),)),
          
                  SizedBox(height: 15,),
          
                  RichText(text: TextSpan(text:"Already have an account? ",
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w600),
                      children:[TextSpan(text: "Signup",
                          style: TextStyle(color: Colors.green))
                      ]
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
