import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/farmequipmentdetails.dart';
import 'package:smartagri/modules/farmer/screens/farmerequipmentlist_screen.dart';
import 'package:smartagri/modules/farmer/screens/farmproductlist_screen.dart';
import 'package:smartagri/modules/user/screens/beveragesScreen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    // Home Page with Cards
    HomePageContent(),
    // Cart Page
    const Center(child: Text('Cart Page', style: TextStyle(fontSize: 24))),
    // Profile Page
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchPressed() {
    // Handle the search action here
    print('Search icon pressed');
  }

  void _onAddPressed() {
    // Handle the add action here
    print('Add icon pressed');
  }

  void _onNotificationPressed() {
    // Handle the notification action here
    print('Notification icon pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Agri',
          style: TextStyle(
            fontFamily: 'Dancing Script', // Change to your desired font family
            fontSize: 20,         // Change to your desired font size
            fontWeight: FontWeight.bold, // Change to your desired font weight
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Open the drawer
            
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchPressed,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _onNotificationPressed,
          ),
        ],
      ),
      drawer: Drawer(
        // Add your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('settings'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('payment'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            // Add more items here
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      
    );
  }
}

class HomePageContent extends StatelessWidget {


   List<Map<String,dynamic>> list= [
     {
       'image' : 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
       'title' : 'Tractor',
       'subtitle' : '',
       'price' : 550.00
     },
     {
       'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpGp3hVwLQzIQH4k8RvTR00bW6mJswUoE1HQ&s',
       'title' : 'Brushcutter',
       'subtitle' : '',
       'price' :280.00
     },
     
     {
       'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDmtBPvo3FVULESCy3-dW8K7KdDvBpZNSyOA&s',
       'title' : 'Waterpump',
       'subtitle' : '',
       'price' : 300.00
     },
     {
       'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzIH_gELrvINTYx83EEJMEzOVdXKJfxw540A&s',
       'title' : 'Cultivator',
       'subtitle' : '',
       'price' : 420.00
     },
     {
       'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLE8cdJVd9MPC6Hwlae6BtQWZmUQfq6dftDA&s',
       'title' : 'Combine',
       'subtitle' : '',
       'price' : 840.00
     },
     {
       'image' : 'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
       'title' : 'Spade',
       'subtitle' : '',
       'price' : 48.00
     },
   ];

   List categorieslist=[
    {
      'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMcKnkjU6Flrtc-Vjd0uzSmNv68h-duaITvw&s',
      'title':'Vegetables'
    },
    {
      'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpX1Ut5eFtME_JjgpQhH89wDito-zZiVo4Kw&s',
      'title':'Fruits'
    },
    {
      'image':'https://as2.ftcdn.net/v2/jpg/03/97/86/81/1000_F_397868193_nUAOTup7Z8R4kijdaJ9BuCwVSi8LobpR.jpg',
      'title':'Seeds'
    },
    {
      'image':'https://img.freepik.com/premium-photo/legumes-white-isolated-background_982005-10433.jpg',
      'title':'Legumes'
    },
    {
      'image':'https://as1.ftcdn.net/v2/jpg/00/60/25/94/1000_F_60259460_5ABiMHI7kE3c7vRTS8KW0Nv50EnxYX6T.jpg',
      'title':'Tubers'
    },
    {
      'image':'https://thumbs.dreamstime.com/b/mixed-nuts-group-isolated-white-background-37777972.jpg',
      'title':'Nuts'
    },


   ];




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
        
        
            CarouselSlider(
          options: CarouselOptions(height: 150.0),
          items: [
        
            Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network('https://t3.ftcdn.net/jpg/06/58/31/10/360_F_658311073_jv0oobaa7DOjWlya5LeEx2Wq64iRLyhB.jpg',fit: BoxFit.cover,))
            
            ,)
          
          ]
          
        ),
        SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Equipments"),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context) => FarmEquipmentListScreen(),));
              },
               child:Row(
                 children: [
                   Text("see all "),
                   Icon(Icons.arrow_right,),
        
        
                 ],
               )
              )
            ],),
            SizedBox(
              
              width: double.maxFinite,
              child:Wrap(
                alignment: WrapAlignment.center,
                
                children: list.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>FarmEquipmentsDetails(image: e['image'], title: e['title'], subtitle: e['subtitle'], price: e['price'], value: e),) );
                    },
                    child: Card(
                      color: Colors.white,
                    child: Column(
                    children: [
                      Image.network(e['image'],height: 100,width: 100,),
                      Text(e['title']),
                                    
                    ],
                                    ),
                    ),
                  );
                },).toList()
                 
                 
                
                
                
                
              )
            ),
          
        
        
          SizedBox(height: 30,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Products"),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => FarmProductListScreen(),) );
              },
               child:Row(
                 children: [
                   Text("see all "),
                   Icon(Icons.arrow_right,),
        
        
                 ],
               )
              )
            ],),
                 SizedBox(
              
              width: double.maxFinite,
              child:Wrap(
                alignment: WrapAlignment.center,
                
                children: categorieslist.map((e) {
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Card(
                      color: Colors.white,
                    child: Column(
                    children: [
                      Image.network(e['image'],height: 100,width: 100,),
                      Text(e['title']),
                                    
                    ],
                                    ),
                    ),
                  );
                },).toList()
                 
                 
                
                
                
                
              )
            ),
          
        
        
         
          ],
        ),
      ),
    );
  }
}
