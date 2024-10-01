import 'package:flutter/material.dart';

class WaterpumpScreen extends StatelessWidget {
  const WaterpumpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for water pumps including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere WP75',
        'company': 'John Deere',
        'description': '75 HP, high-efficiency water pump for large irrigation systems.',
        'imageUrl': 'https://example.com/john-deere-waterpump.jpg',
        'rentRate': '\$85/day'
      },
      {
        'name': 'Mahindra MP45',
        'company': 'Mahindra',
        'description': '45 HP, medium-duty water pump for efficient water flow in farms.',
        'imageUrl': 'https://example.com/mahindra-waterpump.jpg',
        'rentRate': '\$65/day'
      },
      {
        'name': 'Kubota WP60',
        'company': 'Kubota',
        'description': '60 HP, fuel-efficient water pump with durable construction.',
        'imageUrl': 'https://example.com/kubota-waterpump.jpg',
        'rentRate': '\$70/day'
      },
      {
        'name': 'New Holland WP80',
        'company': 'New Holland',
        'description': '80 HP, heavy-duty water pump for high-volume irrigation.',
        'imageUrl': 'https://example.com/new-holland-waterpump.jpg',
        'rentRate': '\$90/day'
      },
      {
        'name': 'Swaraj WP50',
        'company': 'Swaraj',
        'description': '50 HP, versatile water pump for regular farm irrigation needs.',
        'imageUrl': 'https://example.com/swaraj-waterpump.jpg',
        'rentRate': '\$60/day'
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
        title: const Text('Waterpump Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE WATERPUMPS FOR RENT',
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
