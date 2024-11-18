import 'package:flutter/material.dart';

// Dummy data for suppliers
class ManageSupplierScreen extends StatelessWidget {
  ManageSupplierScreen({super.key});

  final List<Map<String, String>> suppliers = [
    {'name': 'Supplier A', 'email': 'supplierA@example.com'},
    {'name': 'Supplier B', 'email': 'supplierB@example.com'},
    {'name': 'Supplier C', 'email': 'supplierC@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Supplier',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: suppliers.length,
                itemBuilder: (context, index) {
                  final supplier = suppliers[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 40,
                      ),
                      title: Text(
                        supplier['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(supplier['email']!),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'view',
                            child: const Text('View'),
                          ),
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text('Edit'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text('Delete'),
                          ),
                        ],
                        onSelected: (value) {
                          // Handle menu item actions here
                          if (value == 'view') {
                            // Navigate to the SupplierDetails page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupplierDetails(
                                  name: supplier['name']!,
                                  email: supplier['email']!,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$value ${supplier['name']}')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the Add Supplier page (you can replace this with your add supplier logic)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add Supplier Tapped')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Supplier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SupplierDetails Page to show details
class SupplierDetails extends StatelessWidget {
  final String name;
  final String email;

  const SupplierDetails({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Supplier Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $email',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Handle your edit or delete functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit/Delete functionality')),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Supplier'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
