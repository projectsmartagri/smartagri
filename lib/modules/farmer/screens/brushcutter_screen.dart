import 'package:flutter/material.dart';

class BrushcutterScreen extends StatelessWidget {
  const BrushcutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for brushcutters including names, descriptions, company names, image URLs, and rent rates
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'John Deere X950R',
        'company': 'John Deere',
        'description': 'Heavy-duty brushcutter, ideal for rugged terrain and tall grass.',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_VM4opuy4P8FgJbXgL2bhJZvAvB7b9I1hJg&s',
        'rentRate': '₹70/day'
      },
    
      {
        'name': 'Kubota RC1880',
        'company': 'Kubota',
        'description': 'Compact and powerful, perfect for both professional and domestic use.',
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDRYJn61jV8P5hW1nvziEIa9mMLeDmNKGuvQ&s',
        'rentRate': '₹65/day'
      },
      {
        'name': 'New Holland BC110',
        'company': 'New Holland',
        'description': 'Durable brushcutter, designed for extreme conditions and long hours of work.',
        'imageUrl': 'https://toptools.in/media/catalog/product/cache/1/small_image/300x300/9df78eab33525d08d6e5fb8d27136e95/e/m/em2500.jpg',
        'rentRate': '₹75/day'
      },
      {
        'name': 'Swaraj BC50',
        'company': 'Swaraj',
        'description': 'Reliable and easy-to-use brushcutter for everyday garden maintenance.',
        'imageUrl': 'https://redrhino.co.za/cdn/shop/products/RedRhinoCG430BrushcutterSBCG430B-6009801316666-Copy.jpg?v=1662704068',
        'rentRate': '₹55/day'
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
        title: const Text('Brushcutter Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AVAILABLE BRUSHCUTTERS FOR RENT',
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
