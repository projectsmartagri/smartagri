import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';
import 'package:smartagri/modules/supplier/services/supplier_machinery_service.dart';
import 'package:smartagri/utils/helper.dart';
import 'package:intl/intl.dart';

class SupplierEquipmentDetailsScreen extends StatefulWidget {
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
  State<SupplierEquipmentDetailsScreen> createState() => _SupplierEquipmentDetailsScreenState();
}

class _SupplierEquipmentDetailsScreenState extends State<SupplierEquipmentDetailsScreen> {
  Future<List<Map<String,dynamic>>> fetchFarmerAndRentalData(String id) async {
    try {
      // Querying the 'rental_order' collection for documents where 'machineryId' is equal to the provided id
      QuerySnapshot rentalSnapshot = await FirebaseFirestore.instance
          .collection('rental_order')
          .where('machineryId', isEqualTo: id)
          .get();

      List<Map<String, dynamic>> farmerAndRentalData = [];
      final dateFormatter = DateFormat('yyyy-MM-dd');

      // Loop through the documents in the snapshot
      for (var doc in rentalSnapshot.docs) {
        // Accessing the data of each document
        Map<String, dynamic> rentalData = doc.data() as Map<String, dynamic>;
        String docId = doc.id;
        bool isReturned = rentalData['isReturned'] ?? false;

        // Fetching farmer data
        String uid = rentalData['uid'];
        
        DocumentSnapshot farmerSnapshot = await FirebaseFirestore.instance.collection('farmers').doc(uid).get();

        // Get the farmer's name from the snapshot
        String farmerName = farmerSnapshot.exists ? farmerSnapshot['name'] ?? 'Unknown' : 'Unknown';
        String bookingDate = dateFormatter.format((rentalData['bookedAt'] as Timestamp).toDate());
        String returnDate = rentalData['endDate'] != null
            ? dateFormatter.format((rentalData['endDate'] as Timestamp).toDate())
            : 'Not Returned';

        int quantityBooked = rentalData['quantity'] ?? 0;

        // Add the rental data and the farmer name to the list
        farmerAndRentalData.add({
          'isReturned': isReturned,
          'rentalId': docId,
          'ProductId': rentalData['machineryId'],
          'bookingDate': bookingDate,
          'returnDate': returnDate,
          'farmer': farmerName,
          'quantity': quantityBooked,  // Add the farmer's name here
        });
      }

      // Print the list to check the updated data
      return farmerAndRentalData;

    } catch (e) {
      rethrow;
    }
  }

  void deleteMachinery() async {
    try {
      await SupplierMachineryService().machinarydel(widget.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Machinery deleted successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to delete machinery.')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    id: widget.id,
                    initialName: widget.name,
                    initialImageUrl: widget.imageUrl,
                    initialRentRate: widget.rentRate,
                    initialDescription: widget.description,
                    initialQuantity: widget.quantity,
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
                      child: Image.network(widget.imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 16),
                    Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 8),
                    Text('Rent Rate: ${widget.rentRate}/day', style: TextStyle(fontSize: 20, color: Colors.green)),
                    const SizedBox(height: 8),
                    Text(widget.description, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 16),
                    Text('Quantity Available: ${widget.quantity}', style: TextStyle(fontSize: 18, color: Colors.orange)),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),
            const Text('Farmers Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            FutureBuilder(
              future: fetchFarmerAndRentalData(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.green));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error Fetching data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[100],
                            child: const Icon(Icons.person, color: Colors.green),
                          ),
                          title: Text(order['farmer'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity Booked: ${order['quantity']}'),
                              Text('Booking Date: ${order['bookingDate']}',style: const TextStyle(
                                  color: Colors.green,),),
                              Text( 'Return Date: ${order['returnDate']}',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
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
    int parsedQuantity = int.tryParse(_quantityController.text) ?? 0;
    int parsedRentRate = int.tryParse(_rentRateController.text) ?? 0;

    SupplierMachineryService().machinaryedit(
      name: _nameController.text,
      imageUrl: widget.initialImageUrl,
      rentRate: parsedRentRate, // Store rentRate as int
      description: _descriptionController.text,
      quantity: parsedQuantity, // Store quantity as int
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
