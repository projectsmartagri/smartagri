import 'package:flutter/material.dart';

class RotavatorScreen extends StatelessWidget {
  const RotavatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for rotavators including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere Rotavator Model 1',
        'company': 'John Deere',
        'description': 'High-performance rotavator for efficient soil preparation.',
        'imageUrl': 'https://example.com/john-deere-rotavator.jpg',
        'rentRate': '\$15/day'
      },
      {
        'name': 'Mahindra Rotavator Model 2',
        'company': 'Mahindra',
        'description': 'Durable and reliable rotavator ideal for all soil types.',
        'imageUrl': 'https://example.com/mahindra-rotavator.jpg',
        'rentRate': '\$12/day'
      },
      {
        'name': 'Kubota Rotavator Model 3',
        'company': 'Kubota',
        'description': 'Compact rotavator designed for small to medium farms.',
        'imageUrl': 'https://example.com/kubota-rotavator.jpg',
        'rentRate': '\$13/day'
      },
      {
        'name': 'New Holland Rotavator Model 4',
        'company': 'New Holland',
        'description': 'Versatile rotavator with excellent tillage capabilities.',
        'imageUrl': 'https://example.com/new-holland-rotavator.jpg',
        'rentRate': '\$11/day'
      },
      {
        'name': 'Swaraj Rotavator Model 5',
        'company': 'Swaraj',
        'description': 'Efficient rotavator for deep tillage and soil aeration.',
        'imageUrl': 'https://example.com/swaraj-rotavator.jpg',
        'rentRate': '\$10/day'
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
        title: const Text('Rotavator Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE ROTAVATORS FOR RENT',
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
