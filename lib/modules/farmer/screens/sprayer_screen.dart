import 'package:flutter/material.dart';

class SprayerScreen extends StatelessWidget {
  const SprayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for sprayers including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere S500',
        'company': 'John Deere',
        'description': '500-liter capacity, high-efficiency field sprayer for large crops.',
        'imageUrl': 'https://example.com/john-deere-sprayer.jpg',
        'rentRate': '\$100/day'
      },
      {
        'name': 'Mahindra SP300',
        'company': 'Mahindra',
        'description': '300-liter capacity, medium-duty sprayer for effective pesticide application.',
        'imageUrl': 'https://example.com/mahindra-sprayer.jpg',
        'rentRate': '\$75/day'
      },
      {
        'name': 'Kubota KS400',
        'company': 'Kubota',
        'description': '400-liter capacity, durable and fuel-efficient sprayer for mid-size farms.',
        'imageUrl': 'https://example.com/kubota-sprayer.jpg',
        'rentRate': '\$80/day'
      },
      {
        'name': 'New Holland NS600',
        'company': 'New Holland',
        'description': '600-liter capacity, heavy-duty sprayer designed for large-scale agriculture.',
        'imageUrl': 'https://example.com/new-holland-sprayer.jpg',
        'rentRate': '\$110/day'
      },
      {
        'name': 'Swaraj SS350',
        'company': 'Swaraj',
        'description': '350-liter capacity, versatile sprayer for general farm use.',
        'imageUrl': 'https://example.com/swaraj-sprayer.jpg',
        'rentRate': '\$70/day'
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
        title: const Text('Sprayer Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE SPRAYERS FOR RENT',
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
