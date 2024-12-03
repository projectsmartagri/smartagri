import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/modules/user/screens/User_loginScreen.dart';

import '../view_model/auth_view_model.dart';

import 'package:image_picker/image_picker.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  List<Map<String, dynamic>> list = [
    {'image': 'asset/images/ordersIconAccount.png', 'text': 'Orders'},
    {'image': 'asset/images/MyDetailsiconAccount.png', 'text': 'My Details '},
    {'image': 'asset/images/de;iveryAccount.png', 'text': 'Delivery Address'},
    {'image': 'asset/images/paymentAccount.png', 'text': 'Payment Method'},
    {'image': 'asset/images/promocodeAccount.png', 'text': 'Promo Code'},
    {'image': 'asset/images/belliconAccount.png', 'text': 'Notifications'},
    {'image': 'asset/images/helpiconAccount.png', 'text': 'Help'},
    {'image': 'asset/images/abouticonAccount.png', 'text': 'About'}
  ];

  File ? image;







  // // This is the image picker
  Future<void> pickImage({required ImageSource source}) async {


    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    image = File(pickedImage!.path);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


      final authViewModel = Provider.of<AuthViewModel>(context);
      final  user = authViewModel.user;



    return SafeArea(
        child: Scaffold(
      body:  authViewModel.isLoading ? const Center(child: CircularProgressIndicator(color: Colors.green,),)  :  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Stack(
                  children:[
                    CircleAvatar(
                    radius:60,
                      backgroundImage:image==null ? NetworkImage(user!.profileImageUrl!) :FileImage(image!) ,


                  ),

                    Positioned(
                        right: -8,
                        bottom: 0,
                        child: ElevatedButton(

                          onPressed: () {
                            showModalBottomSheet(
                                context: context, builder: (context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              pickImage(source: ImageSource.gallery);



                                            }, child: const Text('Gallery')),
                                        ElevatedButton(
                                            onPressed: () async {

                                              Navigator.pop(context);
                                              pickImage(source: ImageSource.camera);


                                            }, child: const Text('Camera'))
                                      ],
                                    ),
                                  );
                                });


                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.blue, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                          child: Icon(Icons.add,size: 18, color: Colors.white),
                        )
                    )

        ],
      ),

                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'Afsar Hossen',
                        maxLines: 1,
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                         user?.email ??   'Imshuvo97@gmail.com',
                        style: const TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 5,
              ),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image.asset(list[index]['image']),
                      const SizedBox(
                         width: 15,
                      ),
                      Text(
                        list[index]['text'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: Color(0xff53B175),
                  fixedSize: const Size(364, 67)),
              onPressed: () {
<<<<<<< HEAD
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>UserLoginscreen(),), (route) => false,);
=======
<<<<<<< HEAD
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Loginscreen(),), (route) => false,);
=======
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>UserLoginscreen(),), (route) => false,);
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
              },
              child: Row(
                children: [
                  const Icon(Icons.logout,
                  color: Colors.green,),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        authViewModel.logout(context);
                      },
                      child: const Text(
                        'Log Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
