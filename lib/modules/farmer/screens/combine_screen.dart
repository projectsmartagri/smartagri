import 'package:flutter/material.dart';

class CombineScreen extends StatelessWidget {
  const CombineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for combines including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere Combine Model 1',
        'company': 'John Deere',
        'description': 'High-efficiency combine harvester for large farms.',
        'imageUrl': 'https://example.com/john-deere-combine.jpg',
        'rentRate': '\$200/day'
      },
      {
        'name': 'Mahindra Combine Model 2',
        'company': 'Mahindra',
        'description': 'Robust and versatile combine suitable for various crops.',
        'imageUrl': 'https://example.com/mahindra-combine.jpg',
        'rentRate': '\$180/day'
      },
      {
        'name': 'Kubota Combine Model 3',
        'company': 'Kubota',
        'description': 'Compact combine designed for small to medium farms.',
        'imageUrl': 'https://example.com/kubota-combine.jpg',
        'rentRate': '\$170/day'
      },
      {
        'name': 'New Holland Combine Model 4',
        'company': 'New Holland',
        'description': 'Heavy-duty combine with advanced harvesting technology.',
        'imageUrl': 'https://example.com/new-holland-combine.jpg',
        'rentRate': '\$190/day'
      },
      {
        'name': 'Swaraj Combine Model 5',
        'company': 'Swaraj',
        'description': 'Efficient and affordable combine for farmers.',
        'imageUrl': 'https://example.com/swaraj-combine.jpg',
        'rentRate': '\$160/day'
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
        title: const Text('Combine Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE COMBINES FOR RENT',
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
