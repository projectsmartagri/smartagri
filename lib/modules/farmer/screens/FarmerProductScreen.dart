import 'package:flutter/material.dart';

class FarmerProductScreen extends StatelessWidget {
  const FarmerProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categoriesList = [
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMcKnkjU6Flrtc-Vjd0uzSmNv68h-duaITvw&s',
        'title': 'Vegetables',
      },
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpX1Ut5eFtME_JjgpQhH89wDito-zZiVo4Kw&s',
        'title': 'Fruits',
      },
      {
        'image': 'https://as2.ftcdn.net/v2/jpg/03/97/86/81/1000_F_397868193_nUAOTup7Z8R4kijdaJ9BuCwVSi8LobpR.jpg',
        'title': 'Seeds',
      },
      {
        'image': 'https://img.freepik.com/premium-photo/legumes-white-isolated-background_982005-10433.jpg',
        'title': 'Legumes',
      },
      {
        'image': 'https://as1.ftcdn.net/v2/jpg/00/60/25/94/1000_F_60259460_5ABiMHI7kE3c7vRTS8KW0Nv50EnxYX6T.jpg',
        'title': 'Tubers',
      },
      {
        'image': 'https://thumbs.dreamstime.com/b/mixed-nuts-group-isolated-white-background-37777972.jpg',
        'title': 'Nuts',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Product Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FarmProductListScreen()),
                    );
                  },
                  child: Row(
                    children: const [
                      Text("See all"),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: categoriesList.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddProductScreen()),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 3,
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  e['image']!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  e['title']!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmProductListScreen extends StatelessWidget {
  const FarmProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Products"),
      ),
      body: const Center(
        child: Text("Farm Product List Screen"),
      ),
    );
  }
}

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: const Center(
        child: Text("Add Product Screen"),
      ),
    );
  }
}
