import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/EquipmentListCompanies.dart';
import 'package:smartagri/modules/farmer/screens/FarmerCompanyEquipment.dart';
import 'package:smartagri/modules/farmer/screens/FarmerOrderScreen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProductScreen.dart';
import 'package:smartagri/modules/farmer/screens/FarmerProfileScreen.dart';
import 'package:smartagri/modules/farmer/screens/addproduct_screen.dart';
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

<<<<<<< HEAD
  static List<Widget> _pages = <Widget>[
    
=======
<<<<<<< HEAD
  static final List<Widget> _pages = <Widget>[
    // Home Page with Cards
=======
  static List<Widget> _pages = <Widget>[
    
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
    HomePageContent(),
    FarmerOrderScreen (),
    FarmerProductScreen(),
   FarmerProfileScreen(),
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
<<<<<<< HEAD
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _selectedIndex == 0
        ? AppBar(
            title: const Text(
              'Smart Agri',
              style: TextStyle(
                fontFamily: 'Dancing Script',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
=======
<<<<<<< HEAD
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
            const DrawerHeader(
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
              title: const Text('settings'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: const Text('payment'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            // Add more items here
          ],
        ),
      ),
=======
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _selectedIndex == 0
        ? AppBar(
            title: const Text(
              'Smart Agri',
              style: TextStyle(
                fontFamily: 'Dancing Script',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _onSearchPressed,
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FarmerNotificationScreen()),
                  );
                },
              ),
            ],
          )
        : null, // Hide the AppBar for other screens
 
<<<<<<< HEAD
=======
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
             
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'My products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
         unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      
    );
  }
  
  FarmerNotificationScreen() {}
}




class HomePageContent extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  // List of image URLs for the CarouselSlider
  List<String> carouselImages = [
    'https://5.imimg.com/data5/SELLER/Default/2023/11/364648303/OR/VC/GX/186750549/jangeer-multicrop-thresher-500x500.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTL2wkfKp1i7WvvRbQkiLFmAyiNxctUXuWCQ&s',
    'https://media.licdn.com/dms/image/v2/D5612AQG8JZ0pQy8Dog/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1709282970844?e=2147483647&v=beta&t=EldBFEM6BXbZurlbMZBQbBhsPcrn9Y9TO0JDvXjg92o',
  ];
     List<Map<String, dynamic>> companiesList = [
      {
        'name': 'COMPANY A',
        'image':
            'https://images.pexels.com/photos/281260/pexels-photo-281260.jpeg?cs=srgb&dl=pexels-francesco-ungaro-281260.jpg&fm=jpg',
        'id': '1'
      },
      {
        'name': 'COMPANY B',
        'image':
            'https://img.freepik.com/free-photo/abstract-dark-blurred-background-smooth-gradient-texture-color-shiny-bright-website-pattern-banner-header-sidebar-graphic-art-image_1258-88597.jpg',
        'id': '2'
      },
      {
        'name': 'COMPANY C',
        'image':
            'https://t4.ftcdn.net/jpg/01/16/88/37/360_F_116883786_wuckft1sNw1ouQfJ6FuquZnxea3qBlxy.jpg',
        'id': '3'
      },
      {
        'name': 'COMPANY D',
        'image':
            'https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-background-website-template-frame-business-report_1258-52616.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727740800&semt=ais_hybrid',
        'id': '4'
      },
    ];

  // Example equipment list for the card view
  List<Map<String, dynamic>> equipmentList = [
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
<<<<<<< HEAD

     
  ];

  return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),

        // CarouselSlider
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: carouselImages.map((url) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Equipments",
             style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff181725),
                    fontWeight: FontWeight.bold),),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>FarmEquipmentListScreen(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Text("See all"),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
=======

     
  ];

  return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),

<<<<<<< HEAD
   ];

  HomePageContent({super.key});




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
        
        
            CarouselSlider(
          options: CarouselOptions(height: 150.0),
          items: [
        
            Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            
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
        const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Equipments"),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context) => FarmEquipmentListScreen(),));
              },
               child:const Row(
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
          
        
        
          const SizedBox(height: 30,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Products"),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => FarmProductListScreen(),) );
              },
               child:const Row(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(),));
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
          
        
        
         
=======
        // CarouselSlider
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: carouselImages.map((url) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Equipments",
             style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff181725),
                    fontWeight: FontWeight.bold),),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>FarmEquipmentListScreen(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Text("See all"),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
          ],
        ),

        // Equipment List
       Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16.0,
                runSpacing: 16.0,
                children: equipmentList.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Equipmentlistcompanies(
                            companyId: '1', // Pass the selected company ID
                            companyName: 'Company A', // Pass the selected company name
                          ),
                        ),
                      );
                    },
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Image.network(
                      e['image'],
                      height: 130,
                      width: 130,
                    ),
                    Text(e['title']),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
       ),

        const SizedBox(height: 30),
        const Text("Companies",
         style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff181725),
                    fontWeight: FontWeight.bold),),
        const SizedBox(height: 10),

        // Companies List - Scrolls with entire page
        Column(
          children: companiesList.map((company) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Farmercompanyequipment(
                      companyId: company['id'],
                      companyName: company['name'],
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        company['image'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        company['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  ),
);

}

}





