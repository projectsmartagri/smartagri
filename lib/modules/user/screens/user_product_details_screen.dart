import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smartagri/modules/farmer/screens/farmer_product_edit.dart';

class UserProductDetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot product;

  const UserProductDetailsScreen({super.key, required this.product});

  @override
  State<UserProductDetailsScreen> createState() => _UserProductDetailsScreenState();
}

class _UserProductDetailsScreenState extends State<UserProductDetailsScreen> {
  // Method to delete the product from Firestore
  Future<void> deleteProduct(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(widget.product.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
      Navigator.pop(context); // Go back to the previous screen after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete product')),
      );
    }
  }

  // Navigate to the edit screen (you would need to implement this screen)
  void editProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: widget.product),
      ),
    );
  }

  // Method to view the farmer's details
  void viewFarmerDetails(BuildContext context) {
    String farmerId = widget.product['farmerId'];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerDetailsScreen(farmerId: farmerId),
      ),
    );
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
    var cartDoc = FirebaseFirestore.instance.collection('users').doc(userId).collection('cart').doc(productId);

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
    return Scaffold(
      bottomSheet:  Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: (){

                  _addToCart(widget.product.id,widget.product['title'] , widget.product['imageUrl'], widget.product['price']);

                },
                child: const Text('Add to cart', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
        
          
      
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),

                // Image Section
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.product['imageUrl'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Product Title and Price Section
                Text(
                  widget.product['title'],
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${widget.product['price']}/kg",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 16),

                // Category Section
                Row(
                  children: [
                    Icon(Icons.category, color: Colors.green[700]),
                    const SizedBox(width: 8),
                    Text(
                      widget.product['category'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                const SizedBox(height: 16),

                // Product Description Section
                Text(
                  "Product Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.product['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                const SizedBox(height: 16),

                // View Farmer Details Button
                ElevatedButton(
                  onPressed: () => viewFarmerDetails(context),
                  child: const Text('View Farmer Details', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class FarmerDetailsScreen extends StatelessWidget {
  final String farmerId;

  const FarmerDetailsScreen({super.key, required this.farmerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [

            SizedBox(height: 60,),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('farmers').doc(farmerId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Farmer not found.'));
                }

                var farmer = snapshot.data!;
                var name = farmer['name'];
                var phone = farmer['phone'];
                var email = farmer['email'] ?? 'N/A';
                var profileImageUrl = farmer['profileImageUrl'] ?? '';
                var location = farmer['location'] ?? 'N/A';
                var isApproved = farmer['isApproved'] ?? false;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Farmer Profile Image
                      if (profileImageUrl.isNotEmpty)
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profileImageUrl),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Farmer Name
                      ProfileField(label: 'Name', value: name),
                      const SizedBox(height: 8),

                      // Farmer Phone
                      ProfileField(label: 'Phone', value: phone),
                      const SizedBox(height: 8),

                      // Farmer Email
                      ProfileField(label: 'Email', value: email),
                      const SizedBox(height: 8),

                      // Farmer Location
                      ProfileField(label: 'Location', value: location),
                      const SizedBox(height: 8),

                      // Farmer Approval Status
                      ProfileField(label: 'Approved', value: isApproved ? 'Yes' : 'No'),
                      const SizedBox(height: 8),

                      // Show Products of the Farmer
                      const SizedBox(height: 16),
                      const Text(
                        'Products:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(height: 8),

                      // Fetch products from Firestore where farmerId matches
                      StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('products')
      .where('farmerId', isEqualTo: farmerId)
      .snapshots(),
  builder: (context, productSnapshot) {
    if (productSnapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!productSnapshot.hasData || productSnapshot.data!.docs.isEmpty) {
      return const Center(child: Text('No products available.'));
    }

    var products = productSnapshot.data!.docs;
    return SizedBox(
      height: 150,  // Adjust the height as per your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,  // Horizontal scrolling
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  UserProductDetailsScreen(product: product),));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),  // Add spacing between items
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: product['imageUrl'],
                      width: 80,  // Adjust the image width
                      height: 80,  // Adjust the image height
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product['title'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('₹${product['price']}/kg'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  },
)

                    
                    ],
                  ),
                );
              },
            ),
            // Back Button
           
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String? value;

  const ProfileField({required this.label, this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          value ?? 'N/A',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const Divider(height: 20, color: Colors.grey),
      ],
    );
  }
}
