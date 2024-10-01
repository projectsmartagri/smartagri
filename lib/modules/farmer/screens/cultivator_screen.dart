import 'package:flutter/material.dart';

class CultivatorScreen extends StatelessWidget {
  const CultivatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for cultivators including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere Cultivator Model 1',
        'company': 'John Deere',
        'description': 'High-efficiency cultivator for optimal soil conditioning.',
        'imageUrl': 'https://example.com/john-deere-cultivator.jpg',
        'rentRate': '\$18/day'
      },
      {
        'name': 'Mahindra Cultivator Model 2',
        'company': 'Mahindra',
        'description': 'Robust cultivator designed for various field conditions.',
        'imageUrl': 'https://example.com/mahindra-cultivator.jpg',
        'rentRate': '\$15/day'
      },
      {
        'name': 'Kubota Cultivator Model 3',
        'company': 'Kubota',
        'description': 'Compact and versatile cultivator for effective tillage.',
        'imageUrl': 'https://example.com/kubota-cultivator.jpg',
        'rentRate': '\$16/day'
      },
      {
        'name': 'New Holland Cultivator Model 4',
        'company': 'New Holland',
        'description': 'Heavy-duty cultivator for improved soil aeration.',
        'imageUrl': 'https://example.com/new-holland-cultivator.jpg',
        'rentRate': '\$14/day'
      },
      {
        'name': 'Swaraj Cultivator Model 5',
        'company': 'Swaraj',
        'description': 'Efficient cultivator suitable for all soil types.',
        'imageUrl': 'https://example.com/swaraj-cultivator.jpg',
        'rentRate': '\$13/day'
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
        title: const Text('Cultivator Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE CULTIVATORS FOR RENT',
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
