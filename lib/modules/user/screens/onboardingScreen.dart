import 'package:flutter/material.dart';
import 'package:smartagri/modules/user/screens/User_loginScreen.dart';


class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    print(ht/18.73);

    print(ht);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('asset/images/8140 1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('asset/images/carrot.png'),
              const SizedBox(height: 10,),
              
              Text('Welcome \n to our store',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ht/18.73,
                fontFamily: 'Gilroy',
                color: Colors.white
              ),),
              
              const Text('Get your groceries in as fast as one hour',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Gilroy'
              ),),

              const SizedBox(height: 40,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 67,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    fixedSize: const Size(353, 67),
                    backgroundColor: const Color(0xff53B175),
                  ),
                    onPressed: (){

                    Navigator.push(context,  MaterialPageRoute(builder: (context) => const UserLoginscreen(),));
                    },

                    child: const Text('Get Started',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,fontSize: 18
                    ),)
                ),
              ),

              const SizedBox(height: 90,)
            ],
          ),

        ),

      ),

    );
  }
}
