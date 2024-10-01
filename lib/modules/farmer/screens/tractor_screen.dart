import 'package:flutter/material.dart';

class TractorScreen extends StatelessWidget {
  const TractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for tractors including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere 5075E',
        'company': 'John Deere',
        'description': '75 HP, 4WD, suitable for heavy-duty tasks.',
        'imageUrl': 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
        'rentRate': '\$150/day'
      },
      {
        'name': 'Mahindra 475 DI',
        'company': 'Mahindra',
        'description': '42 HP, efficient for medium farming.',
        'imageUrl': 'https://www.mahindratractor.com/sites/default/files/styles/homepage_pslider_472x390_/public/2023-10/xp_plus.webp',
        'rentRate': '\$120/day'
      },
      {
        'name': 'Kubota MU5501',
        'company': 'Kubota',
        'description': '55 HP, great fuel efficiency.',
        'imageUrl': 'https://cdn.britannica.com/43/128643-004-17C2CD69/Tractor.jpg',
        'rentRate': '\$140/day'
      },
      {
        'name': 'New Holland 3630 TX Plus',
        'company': 'New Holland',
        'description': '50 HP, durable and versatile.',
        'imageUrl': 'https://5.imimg.com/data5/SELLER/Default/2023/5/308608806/LO/XL/TE/159409609/excel-3230-tx-new-holland-tractor.jpg',
        'rentRate': '\$130/day'
      },
      {
        'name': 'Swaraj 744 FE',
        'company': 'Swaraj',
        'description': '48 HP, robust and long-lasting.',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJWpNpA7o3RMLpZQ1IuzwIgb1a_PHXkumvJg&s',
        'rentRate': '\$110/day'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: const Text('Tractor Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE TRACTORS FOR RENT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Space between title and list
            Expanded(
              child: ListView.builder(
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Image on the left
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  equipment['imageUrl']!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10), // Space between image and text
                              Expanded(
                                child: ListTile(
                                  title: Text(equipment['name']!),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        equipment['company']!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(equipment['description']!),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Rent Rate: ${equipment['rentRate']}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Add "Book Now" button at the bottom right
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, // Set background color to green
                                ),
                             onPressed: () {
                                  // Handle the booking action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Booking ${equipment['name']}')),
                                  );
                                },
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(
                                    color: Colors.white, // Set text color to white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
