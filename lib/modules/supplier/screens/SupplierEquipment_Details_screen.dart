import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/services/supplier_machinery_service.dart';
import 'package:smartagri/utils/helper.dart';

class SupplierEquipmentDetailsScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rentRate;
  final String description;
  final int quantity;
  final String id;

  const SupplierEquipmentDetailsScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rentRate,
    required this.description,
    required this.quantity,
    required this.id, required List farmersOrders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> farmersOrders = [
      // Sample data of farmers who ordered this equipment
      {'farmerName': 'Farmer John', 'bookingDate': '2024-10-01', 'dueDate': '2024-10-07', 'returnDate': '2024-10-06'},
      {'farmerName': 'Farmer Alice', 'bookingDate': '2024-10-02', 'dueDate': '2024-10-09', 'returnDate': '2024-10-08'},
      {'farmerName': 'Farmer Bob', 'bookingDate': '2024-10-05', 'dueDate': '2024-10-12', 'returnDate': ''},
      {'farmerName': 'Farmer Charlie', 'bookingDate': '2024-10-03', 'dueDate': '2024-10-10', 'returnDate': ''},
    ];

    void deleteMachinery() async {
      try {
        await SupplierMachineryService().machinarydel(id);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Machinery deleted successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to delete machinery.')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEquipmentScreen(
                    id: id,
                    initialName: name,
                    initialImageUrl: imageUrl,
                    initialRentRate: rentRate,
                    initialDescription: description,
                    initialQuantity: quantity,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Equipment', style: TextStyle(fontWeight: FontWeight.bold)),
                  content: const Text('Are you sure you want to delete this equipment?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        deleteMachinery();
                        Navigator.pop(context);
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 16),
                    Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 8),
                    Text('Rent Rate: $rentRate/day', style: TextStyle(fontSize: 20, color: Colors.green)),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 16),
                    Text('Quantity Available: $quantity', style: TextStyle(fontSize: 18, color: Colors.orange)),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),
            const Text('Farmers Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: farmersOrders.length,
              itemBuilder: (context, index) {
                final order = farmersOrders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[100],
                      child: const Icon(Icons.person, color: Colors.green),
                    ),
                    title: Text(order['farmerName'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Date: ${order['bookingDate']}'),
                        Text('Due Date: ${order['dueDate']}'),
                        Text(
                          'Return Date: ${order['returnDate']?.isEmpty ?? true ? 'Not Returned' : order['returnDate']}',
                          style: TextStyle(
                            color: order['returnDate']?.isEmpty ?? true ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class EditEquipmentScreen extends StatefulWidget {
  final String initialName;
  String initialImageUrl;
  final String initialRentRate;
  final String initialDescription;
  final int initialQuantity;
  final String id;

  EditEquipmentScreen({
    Key? key,
    required this.initialName,
    required this.initialImageUrl,
    required this.initialRentRate,
    required this.initialDescription,
    required this.initialQuantity,
    required this.id,
  }) : super(key: key);

  @override
  _EditEquipmentScreenState createState() => _EditEquipmentScreenState();
}

class _EditEquipmentScreenState extends State<EditEquipmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentRateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _rentRateController.text = widget.initialRentRate;
    _descriptionController.text = widget.initialDescription;
    _quantityController.text = widget.initialQuantity.toString();
  }

  Future<void> _pickImage() async {
    setState(() => isLoading = true);
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      widget.initialImageUrl = await uploadfile(
        name: 'machine',
        uid: widget.id,
        file: File(image.path),
      );
    }
    setState(() => isLoading = false);
  }

  void _saveChanges() {
    SupplierMachineryService().machinaryedit(
      name: _nameController.text,
      imageUrl: widget.initialImageUrl,
      rentRate: _rentRateController.text,
      description: _descriptionController.text,
      quantity: _quantityController.text,
      id: widget.id,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Equipment', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Edit Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 221, 227, 221),
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                      ),
                    ),
                  ),
                  if (widget.initialImageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget.initialImageUrl, height: 250, fit: BoxFit.cover),
                    ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Equipment Name', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextField(
                    controller: _rentRateController,
                    decoration: const InputDecoration(labelText: 'Rent Rate', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                    maxLines: 3,
                  ),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity', focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      child: const Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
