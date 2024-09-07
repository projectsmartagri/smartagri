import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../view_model/auth_view_model.dart';
import 'accountScreen.dart';
import 'exploreScreen.dart';
import 'favouriteScreen.dart';
import 'homeScreen.dart';
import 'mycartScreen.dart';
import 'searchScreen.dart';

class Bottomnavigationbar extends StatefulWidget {
   Bottomnavigationbar({super.key,this.zone,this.area});

   String ? zone;
   String ? area;

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  
  
  
  List<Widget> pages = [];
  int selectedIndex= 0;
  
  @override
  void initState() {

    // Fetch user data when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.getUser();
    });
    
    pages.addAll([
      Homescreen(zone:widget.zone,area: widget.area,),
      ExploreScreen(),
      // Searchscreen(),
      Mycartscreen(),
      Favouritescreen(),
      Accountscreen()
    ]
    );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    print(widget.area);

    return Scaffold(
     
      body: pages[selectedIndex],

      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            selectedIndex = value;
            setState(() {

            });
          },

          items: [
            BottomNavigationBarItem(label: 'Shop', icon: Icon(Icons.shopping_bag_outlined,color: Colors.black,)),
            BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.manage_search,color: Colors.black,)),
            BottomNavigationBarItem(label: 'Cart', icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,)),
            BottomNavigationBarItem(label: 'Favourites', icon: Icon(Icons.favorite_outline_sharp,color: Colors.black,)),
            BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.account_box_outlined,color: Colors.black,))
          ],
            selectedLabelStyle: TextStyle(color: Colors.black),

        ),
      ),
    );
  }
}
