import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/farmer/screens/farmer_product_edit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // Method to delete the product from Firestore
  Future<void> deleteProduct(BuildContext context) async {
    print(widget.product.id);
    try {
      await FirebaseFirestore.instance.collection('products').doc(widget.product.id).delete();
      setState(() {});
      Navigator.pop(context); // Go back to the previous screen after deletion
    } catch (e) {
      setState(() {});
    }
  }

  // Method to show delete confirmation dialog
  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Confirm Delete",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: const Text(
            "Are you sure you want to delete this product? This action cannot be undone.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                deleteProduct(context); // Perform delete action
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Navigate to the edit screen
  void editProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['title'],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => editProduct(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDeleteConfirmationDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
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
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 8),

                  // Product Quantity Section
                  Text(
                    "Quantity Available: ${widget.product['quantity']} kg",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
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
                  const SizedBox(height: 8),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
