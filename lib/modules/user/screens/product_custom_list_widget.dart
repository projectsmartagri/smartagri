import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartagri/modules/farmer/screens/farmer_product_details_screen.dart';
import 'package:smartagri/modules/user/screens/productdetailScreen.dart';
import 'package:smartagri/modules/user/screens/user_product_details_screen.dart';

class ProductGrid extends StatefulWidget {
  final String cat;
  const ProductGrid({super.key, required this.cat});
  
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch farmer details based on farmerId
  Future<DocumentSnapshot> _fetchFarmerDetails(String farmerId) async {
    return await _firestore.collection('farmers').doc(farmerId).get();
  }

  Future<void> _addToCart(String productId, String name, String imageUrl, double price) async {
  try {
    // Assuming a user is logged in and you have userId available
    String? userId = FirebaseAuth.instance.currentUser?.uid; // Replace with the actual userId

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    // Reference to the user's cart in Firestore
    var cartDoc = _firestore.collection('users').doc(userId).collection('cart').doc(productId);

    // Fetch the cart item if it already exists
    var cartSnapshot = await cartDoc.get();

    if (cartSnapshot.exists) {
      // If the item exists in the cart, increment the quantity
      int currentQuantity = cartSnapshot['quantity'] ?? 0;
      await cartDoc.update({
        'quantity': currentQuantity + 1,
        'addedAt': FieldValue.serverTimestamp(), // Update timestamp when the item is added
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name quantity updated to ${currentQuantity + 1}')),
      );
    } else {
      // If the item does not exist, add it to the cart with quantity 1
      await cartDoc.set({
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'productId': productId,
        'quantity': 1,
        'addedAt': FieldValue.serverTimestamp(), // Timestamp when the item is added
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name added to cart!')),
      );
    }
  } catch (e) {
    // Handle any errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add to cart: $e')),
    );
  }
}


 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.cat == 'All' 
        ? _firestore.collection('products').snapshots() 
        : _firestore.collection('products').where('category', isEqualTo: widget.cat).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 8,
            childAspectRatio: 0.55,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            var productId = product.id;
            var name = product['title'] ?? 'Unnamed';
            var imageUrl = product['imageUrl'] ?? '';
            var price = product['price']?.toDouble() ?? 0.0;
            print(imageUrl);

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => UserProductDetailsScreen(product: product,), ));
              },
              child: Card(
                elevation: 6,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: .5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        imageUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          height: 140,
                          width: double.infinity,
                          child: const Icon(Icons.image_not_supported, size: 50),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        'Price:\₹${price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _addToCart(productId, name, imageUrl, price);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );

  }
  }
