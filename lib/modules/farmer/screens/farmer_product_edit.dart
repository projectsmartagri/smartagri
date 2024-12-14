
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final QueryDocumentSnapshot product;

  const EditProductScreen({super.key, required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // Controllers for the text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // For storing the selected image
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Initialize with the product's current values
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.product['title'] ?? ''; // Prevent null value
    _priceController.text = widget.product['price']?.toString() ?? ''; // Handle price being null
    _categoryController.text = widget.product['category'] ?? ''; // Prevent null value
    _descriptionController.text = widget.product['description'] ?? ''; // Prevent null value
  }


  Future<void> updateProduct() async {
  if (_titleController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _categoryController.text.isEmpty ||
      _descriptionController.text.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Please fill in all fields')));
    return;
  }

  try {
    String? imageUrl;

    // If the user has selected a new image, upload it to Firebase Storage
    if (_selectedImage != null) {
      // Generate a unique filename for the image
      final String uniqueFileName =
          'product_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/$uniqueFileName');

      // Upload task with file
      final uploadTask = storageRef.putFile(_selectedImage!);
       print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
      // Await upload completion
      final snapshot = await uploadTask;
      print('++++++++++++++++++++++++');

      // Get the download URL of the uploaded image
      imageUrl = await snapshot.ref.getDownloadURL();
    } else {
      // If no image was selected, retain the old image URL
      imageUrl = widget.product['imageUrl'];
    }

    // Update the product information in Firestore
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.product.id)
        .update({
      'title': _titleController.text,
      'price': double.parse(_priceController.text),
      'category': _categoryController.text,
      'description': _descriptionController.text,
      'imageUrl': imageUrl,
    });

    // Success message and navigation
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')));
    Navigator.pop(context); // Return to the previous screen
  } catch (e) {
    debugPrint('Error while updating product: $e');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update product')));
  }
}


 
  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.save,color: Colors.white,),
            onPressed: updateProduct,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title input with rounded borders and padding
              _buildInputField(_titleController, 'Product Name', Icons.text_fields),
              const SizedBox(height: 16),

              // Price input with rounded borders and padding
              _buildInputField(_priceController, 'Price (₹)', Icons.attach_money, keyboardType: TextInputType.number),
              const SizedBox(height: 16),

              // Category input with rounded borders and padding
              _buildInputField(_categoryController, 'Category', Icons.category),
              const SizedBox(height: 16),

              // Description input with multi-line and rounded borders
              _buildInputField(_descriptionController, 'Product Description', Icons.description, maxLines: 5),
              const SizedBox(height: 16),

              // Image picker button with rounded corners
              GestureDetector(
                onTap: pickImage,
                child: Card(
                  elevation: 5,
                  color: Colors.green[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.image, color: Colors.green, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          _selectedImage != null ? 'Image selected' : 'Tap to select image',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Display the selected image
              if (_selectedImage != null) ...[
                Image.file(_selectedImage!, width: 150, height: 150, fit: BoxFit.cover),
                const SizedBox(height: 16),
              ],

             
            
            ],
          ),
        ),
      ),
    );
  }

  // Function to create styled input fields
  Widget _buildInputField(TextEditingController controller, String label, IconData icon, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.green),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
