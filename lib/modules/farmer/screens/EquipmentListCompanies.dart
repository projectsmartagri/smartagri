import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartagri/modules/farmer/screens/farmequipmentdetails.dart';

class Equipmentlistcompanies extends StatelessWidget {
  final String companyId;
  final String companyName;

  const  Equipmentlistcompanies({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data for specific equipment of a company
    final List<Map<String, String>> equipmentList = [
      {
        'name': 'equipment A',
        'company': 'COMPANY A',
        'description': '75 HP, 4WD, suitable for heavy-duty tasks.',
        'rentRate': '₹150/day',
        
        'quantity': '10'
      },
      {
       
        'name': 'equipment A',
        'company': 'COMPANY B',
        'description': '42 HP, efficient for medium farming.',
        'rentRate': '₹120/day',
        
        'quantity': '15'
      },
     
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$companyName Equipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: equipmentList.length,
          itemBuilder: (context, index) {
            final equipment = equipmentList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'https://cdn.britannica.com/43/128643-004-17C2CD69/Tractor.jpg', // Replace with actual image URL
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ListTile(
                            title: Text(equipment['name']!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  equipment['company']!,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(equipment['description']!),
                                const SizedBox(height: 8),
                                Text(
                                  'Rent Rate: ${equipment['rentRate']}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Quantity Available: ${equipment['quantity']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //          builder: (context) =>FarmEquipmentsDetails(
                      //            image: '',
                      // title: 'title',
                      // subtitle: '',
                      // price: 0, // Replace with actual price if needed
                     
                      //          ),
                      //         ),
                      //      );
                          },
                          child: const Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
