import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          companyName,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green[800], // Darker green for the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: fetchEquipmentForCompany(companyId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No equipment available.'));
            } else {
              final equipmentList = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;

                return {
                  'id': doc.id,  // Make sure this is never null
                  'name': data['name'] ?? 'Unnamed', // Default to 'Unnamed' if null
                  'price': data['price'] ?? 0, // Default to 0 if null
                  'quantity': data['Quantity'] ?? 0, // Default to 0 if null
                  'image': data['image'] ?? '', // Default to empty string if null
                };
              }).toList();

              return ListView.builder(
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 12, // Stronger shadow for a modern look
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        // Handle null values before navigating
                        final equipmentId = equipment['id'] ?? '';
                       
                        // If id is empty or invalid, do not navigate
                        if (equipmentId.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EquipmentDetailsScreen(
                                id: equipmentId,  // Ensure a valid id is passed
                                machinery:equipment,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid equipment ID')));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Light background for the card
                          borderRadius: BorderRadius.circular(18.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(4, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            equipment['image'] != null && equipment['image'] != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      equipment['image'],
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.image_outlined,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    equipment['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Price: \$${equipment['price'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Quantity: ${equipment['quantity']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.brown[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Stream<QuerySnapshot> fetchEquipmentForCompany(String companyId) {
    final CollectionReference equipmentCollection =
        FirebaseFirestore.instance.collection('machinary');
    return equipmentCollection.where('userid', isEqualTo: companyId).snapshots();
  }
}
