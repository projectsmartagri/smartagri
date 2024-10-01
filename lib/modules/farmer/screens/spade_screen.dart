import 'package:flutter/material.dart';

class SpadeScreen extends StatelessWidget {
  const SpadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for spades including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere Spade Model 1',
        'company': 'John Deere',
        'description': 'Heavy-duty spade designed for tough soil conditions.',
        'imageUrl': 'https://example.com/john-deere-spade.jpg',
        'rentRate': '\$10/day'
      },
      {
        'name': 'Mahindra Spade Model 2',
        'company': 'Mahindra',
        'description': 'Ergonomic spade ideal for gardening and small farms.',
        'imageUrl': 'https://example.com/mahindra-spade.jpg',
        'rentRate': '\$8/day'
      },
      {
        'name': 'Kubota Spade Model 3',
        'company': 'Kubota',
        'description': 'Durable spade made from high-quality steel for longevity.',
        'imageUrl': 'https://example.com/kubota-spade.jpg',
        'rentRate': '\$9/day'
      },
      {
        'name': 'New Holland Spade Model 4',
        'company': 'New Holland',
        'description': 'Lightweight spade suitable for delicate tasks.',
        'imageUrl': 'https://example.com/new-holland-spade.jpg',
        'rentRate': '\$7/day'
      },
      {
        'name': 'Swaraj Spade Model 5',
        'company': 'Swaraj',
        'description': 'Versatile spade great for both planting and digging.',
        'imageUrl': 'https://example.com/swaraj-spade.jpg',
        'rentRate': '\$6/day'
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
        title: const Text('Spade Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE SPADES FOR RENT',
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
