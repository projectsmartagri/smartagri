import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/farmequipmentdetails.dart';

class Farmercompanyequipment extends StatelessWidget {
  final String companyId;
  final String companyName;

  const Farmercompanyequipment({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data: Replace this with your API or database call
    final Map<String, List<Map<String, dynamic>>> companyProducts = {
      companyId: [
        {
          'image': 'https://4.imimg.com/data4/KJ/BY/MY-14831048/john-deere-5050d-tractor.jpg',
          'name': 'Tractor A',
          'price': 500.00,
          'quantity': 10,
        },
        {
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDmtBPvo3FVULESCy3-dW8K7KdDvBpZNSyOA&s',
          'name': 'Waterpump',
          'price': 800.00,
          'quantity': 5,
        },
      ],
    };

    // Get products for the selected company
    final products = companyProducts[companyId] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$companyName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: products.isNotEmpty
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical spacing
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners for a sleek look
                    ),
                    elevation: 5, // Adds shadow for better visual hierarchy
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding inside the card
                      height: 180, // Set a fixed height
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0), // Rounded image corners
                            child: Image.network(
                              product['image'],
                              width: 150, // Increased image size
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0), // Spacing between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    fontSize: 18.0, // Larger text size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0), // Spacing between title and price
                                Text(
                                  'Rent Rate: ₹${product['price'].toStringAsFixed(2)} / hr',
                                  style: const TextStyle(
                                    fontSize: 16.0, // Larger text size
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Available Quantity: ${product['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 26, 25, 25),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                 Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                               child:  ElevatedButton(
                                  onPressed: () {
                                    // Navigate to a booking screen or any other action
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => FarmEquipmentsDetails(
                                    //       image: '',
                                    //        title: '', 
                                    //        subtitle: '', 
                                    //        price: 0,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                   child: Text('Book Now',style: TextStyle(
                                      color: Colors.white, // Change text color to white
                                   ),
                                   ),
                                   
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                       backgroundColor: Colors.green,
                                ),
                              ),
                      ),
                                 ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No products available for $companyName',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  final String productName;
  final double productPrice;

  const BookingScreen({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking for $productName')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Booking Details for $productName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Price per hour: ₹${productPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more booking details and form here
            // For example, a form to specify booking time and date
          ],
        ),
      ),
    );
  }
}
