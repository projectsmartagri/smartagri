import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EquipmentListPagescreen extends StatelessWidget {
  final String companyId;
  final String companyName;

<<<<<<< HEAD
=======
<<<<<<< HEAD
  const EquipmentListPagescreen({super.key, required this.companyId});
=======
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
  EquipmentListPagescreen({
    required this.companyId,
    required this.companyName,
  });
<<<<<<< HEAD
=======
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment for $companyName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchEquipmentForCompany(companyId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
<<<<<<< HEAD
              return const CircularProgressIndicator(); // Loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No equipment available.'); // No data message
=======
<<<<<<< HEAD
              return const CircularProgressIndicator(); // Show loading indicator
=======
              return const CircularProgressIndicator(); // Loading indicator
>>>>>>> refs/remotes/origin/main
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
<<<<<<< HEAD
              return const Text('No equipment available for this company.'); // Show no data message
=======
              return const Text('No equipment available.'); // No data message
>>>>>>> refs/remotes/origin/main
>>>>>>> 75d869e1041501d5ac67dce18a81e74942b56367
            } else {
              final equipmentList = snapshot.data!;
              return ListView.builder(
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: equipment['image'] != null
                          ? Image.network(
                              equipment['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : null,
                      title: Text(equipment['name']),
                      subtitle:
                          Text('\$${equipment['price'].toStringAsFixed(2)}'),
                      onTap: () {
                        print('Tapped on ${equipment['name']}');
                      },
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

  // Fetch equipment data for a company
  Future<List<Map<String, dynamic>>> fetchEquipmentForCompany(
      String companyId) async {
    // Replace with your actual API endpoint
    final String apiUrl =
        'https://yourapi.com/equipment?companyId=$companyId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Map the JSON response to a list of equipment
        return jsonResponse.map((item) {
          return {
            'name': item['name'],
            'image': item['image'],
            'price': item['price'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load equipment');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
