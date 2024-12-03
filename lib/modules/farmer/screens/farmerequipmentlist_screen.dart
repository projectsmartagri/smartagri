import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/EquipmentListCompanies.dart';

class FarmEquipmentListScreen extends StatelessWidget {
  FarmEquipmentListScreen({super.key});

  List<Map<String, dynamic>> list = [
    {
      'image': 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
      'title': 'Tractor',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpGp3hVwLQzIQH4k8RvTR00bW6mJswUoE1HQ&s',
      'title': 'Brushcutter',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDmtBPvo3FVULESCy3-dW8K7KdDvBpZNSyOA&s',
      'title': 'Waterpump',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzIH_gELrvINTYx83EEJMEzOVdXKJfxw540A&s',
      'title': 'Cultivator',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLE8cdJVd9MPC6Hwlae6BtQWZmUQfq6dftDA&s',
      'title': 'Combine',
    },
    {
      'image': 'https://rukminim2.flixcart.com/image/850/1000/kk8mcnk0/shovel-spade/1/e/d/digging-hoe-iron-steel-spade-for-gardening-shovel-tadso-lid-original-imafzmgty4zyny8x.jpeg?q=90&crop=false',
      'title': 'Spade',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLI17EqaqJ8cJR-yjmLsbrRVSQQS-pyU6IA&s',
      'title': 'Sprayer',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRZg7VaXJVb11wTMr2RWIiLhYaXqblnhHCZA&s',
      'title': 'Rotavator',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
<<<<<<< HEAD
      body:SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50,),
        
            const Text('Equipments',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff181725),
              fontWeight: FontWeight.bold
            ),),
        
            const SizedBox(height: 30,),
        
            Expanded(
              child: GridView.builder(
                itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: .7,

                  ),
                  itemBuilder: (Buildcontext, int index) {
                   return  ListCardWidgets(
                     val: list[index],
                     ontab: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmEquipmentsDetails(
                        image:  list[index]['image'],
                        price: list[index]['price'],
                        title:list[index]['title'],
                        subtitle: list[index]['subtitle'],
                        value:  list[index],
                      ),));

                     },
                      image: list[index]['image'],
                      title: list[index]['title'],
                      subtitle: list[index]['subtitle'],
                     price: list[index]['price'].toString(),
                    );
                  },),
            )
          ],
=======
      appBar: AppBar(
        title: Text('Equipments', style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff181725),
                    fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Wrap the entire body in a SingleChildScrollView
          child: Column(
            children: [
            
             
              SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true, // Ensures the GridView doesn't take up infinite space
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for the GridView (scrolling will be handled by the parent SingleChildScrollView)
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: .7,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to EquipmentListCompanies screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Equipmentlistcompanies(
                              companyId: 'company_${index + 1}', // Dynamic ID
                              companyName: list[index]['title'], // Using title as company name
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              list[index]['image'],
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            list[index]['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
>>>>>>> refs/remotes/origin/main
        ),
      ),
    );
  }
}
