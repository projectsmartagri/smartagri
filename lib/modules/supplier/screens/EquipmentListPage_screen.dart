import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final String companyId; // Assuming you pass the userId here
  final String companyName;

  const EquipmentDetailScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture Equipment for $companyName',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green[800], // Darker green for the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[700]!], // Green gradient for agriculture theme
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
                return {
                  'name': doc['name'],
                  'price': doc['price'],
                  'quantity': doc['Quantity'],
                  'availability': doc['availability'],
                  'description': doc['description'],
                  'image': doc['image'],
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 16,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(equipment['image'], height: 200, width: double.infinity, fit: BoxFit.cover),
                                    const SizedBox(height: 15),
                                    Text(
                                      equipment['name'],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Description: ${equipment['description']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.brown[700],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Price: \$${equipment['price']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[600],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Availability: ${equipment['availability']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Quantity: ${equipment['quantity']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[800], // Dark green button
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Light background for the card
                          borderRadius: BorderRadius.circular(18.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(4, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            equipment['image'] != null
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
                                    'Availability: ${equipment['availability']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.orange[700],
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
                            IconButton(
                              icon: Icon(Icons.info_outline, color: Colors.green[700]),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      elevation: 16,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.network(equipment['image']),
                                            const SizedBox(height: 15),
                                            Text(
                                              equipment['name'],
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Description: ${equipment['description']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.brown[700],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Price: \$${equipment['price']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green[600],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Availability: ${equipment['availability']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.orange[800],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Quantity: ${equipment['quantity']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green[700],
                                              ),
                                              child: Text('Close'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
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
    final CollectionReference equipmentCollection = FirebaseFirestore.instance.collection('machinary');
    return equipmentCollection
        .where('userid', isEqualTo: companyId)
        .snapshots();
  }
}
