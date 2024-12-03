import 'package:flutter/material.dart';

import '../utils/helper.dart';
import 'User_loginScreen.dart';

class Locationscreen extends StatefulWidget {
  const Locationscreen({super.key});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  List<String> items = ['Banasree', 'Vatakara', 'payyoli', 'Quilandy'];

  List<String> loc = [
    'Dhaka',
    'Town',
  ];

  String? selectedValue;
  String? selectedLoc;

  String? dropdownError;
  String ? dropdownErrorArea;



  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20),

                  width: wt / 1.83,
                  height: ht / 5.27,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'asset/images/location.png',
                    )),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),

                Text(
                  'Select Your Location',
                  style: TextStyle(
                      color: const Color(0xff181725),
                      fontWeight: FontWeight.w600,
                      fontSize: ht / 34.59),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Switch on your location to stay in tune with \nwhats happening in your area',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff7C7C7C),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Zone',
                    style: TextStyle(fontSize: 16, color: Color(0xff7C7C7C)),
                  ),
                ),

                // TextField(
                //   decoration: InputDecoration(
                //       labelText: 'Your Zone'
                //   ),
                // ),
                //
                // SizedBox(height: 10,),
                // TextField(
                //   decoration: InputDecoration(
                //       labelText: 'Your Area'
                //   ),
                // ),

                DropdownButton(
                  isExpanded: true,
                  // hint: Text('Your Zone'),
                  value: selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                if (dropdownError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      dropdownError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const SizedBox(
                  height: 18,
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Area',
                    style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                  ),
                ),

                DropdownButton(
                  isExpanded: true,
                  hint: const Text('Type of your area'),
                  value: selectedLoc,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: loc.map((String loc) {
                    return DropdownMenuItem(
                      value: loc,
                      child: Text(loc),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedLoc = value;
                    });
                  },
                ),

                if (dropdownErrorArea != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      dropdownErrorArea!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),


                const SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      fixedSize: const Size(364, 67),
                      backgroundColor: const Color(0xff53B175),
                    ),
                    onPressed: () {
                     dropdownError=   validateDropdown(value: selectedValue);
                     dropdownErrorArea = validateDropdown(value: selectedLoc);
                     setState(() {

                     });


                      if (dropdownError == null && dropdownErrorArea==null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserLoginscreen(zone: selectedValue,area: selectedLoc,),
                          ),
                          (route) => false,
                        );
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Loginscreen(),));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
