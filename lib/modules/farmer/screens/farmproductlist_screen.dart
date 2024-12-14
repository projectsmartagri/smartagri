import 'package:flutter/material.dart';

class FarmproductlistScreen extends StatelessWidget {
  final String category;
  final List<Map<String, String>> products;

  const FarmproductlistScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // Example products for fallback if no products are passed
    List<Map<String, String>> exampleProducts = [
      {
        'name': 'Tomato',
        'category': 'Vegetables',
        'price': '3.50',
        'image': 'https://via.placeholder.com/150?text=Tomato',
      },
      {
        'name': 'Cucumber',
        'category': 'Vegetables',
        'price': '2.00',
        'image': 'https://via.placeholder.com/150?text=Cucumber',
      },
    ];

    // Use products list if available, otherwise use exampleProducts
    final productList = products.isNotEmpty ? products : exampleProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Products'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productList.isEmpty
            ? const Center(
                child: Text(
                  'No products available in this category.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(
                        product['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product['name']!),
                      subtitle: Text('Price: \$${product['price']}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
