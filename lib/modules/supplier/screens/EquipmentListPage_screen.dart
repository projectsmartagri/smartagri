import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For converting JSON responses

class EquipmentListPagescreen extends StatelessWidget {
  final String companyId;

  const EquipmentListPagescreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment for Company ID: $companyId'),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: fetchEquipmentForCompany(companyId), // Call to the API function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Show error
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No equipment available for this company.'); // Show no data message
            } else {
              final equipmentList = snapshot.data!;
              return ListView.builder(
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(equipmentList[index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<String>> fetchEquipmentForCompany(String companyId) async {
    // Replace with your actual API endpoint
    final String apiUrl = 'https://yourapi.com/equipment?companyId=$companyId';

    try {
      // Perform the HTTP GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonResponse = json.decode(response.body);
        
        // Convert the list of dynamic objects to a list of Strings (or your Equipment class)
        return jsonResponse.map((item) => item['name'] as String).toList();
      } else {
        throw Exception('Failed to load equipment'); // Handle error response
      }
    } catch (e) {
      throw Exception('Failed to load equipment: $e'); // Handle exceptions
    }
  }
}
