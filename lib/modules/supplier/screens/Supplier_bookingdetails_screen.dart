import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SupplierBookingDetailsScreen extends StatefulWidget {
  const SupplierBookingDetailsScreen({super.key});

  @override
  _SupplierBookingDetailsScreenState createState() =>
      _SupplierBookingDetailsScreenState();
}

class _SupplierBookingDetailsScreenState
    extends State<SupplierBookingDetailsScreen> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateController = TextEditingController(); // For date input
  List<QueryDocumentSnapshot> filteredOrders = [];
  List<Map<String, dynamic>> filteredDetails = [];
  double totalCompletedAmount = 0.0;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            );
          },
        ),
        title: const Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildSearchAndDateFilter(),
              const SizedBox(height: 16),
              _buildBookingDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndDateFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by Farmer',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: _searchBooking,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Select Date',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            readOnly: true,
            onTap: _selectDate, // To open the date picker
          ),
        ),
      ],
    );
  }

  Widget _buildBookingDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bookings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 8),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('rental_order')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.green));
              }

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              List<QueryDocumentSnapshot> rentalOrders = snapshot.data!.docs;

              return FutureBuilder(
                future: _fetchFarmerAndMachineryDetails(rentalOrders),
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.green));
                  }

                  if (dataSnapshot.hasError) {
                    return Center(child: Text('Error fetching data'));
                  }

                  List<Map<String, dynamic>> details = dataSnapshot.data!;
                  filteredOrders = rentalOrders;
                  filteredDetails = details;

                  if (selectedDate != null) {
                    filteredOrders = filteredOrders.where((order) {
                      Timestamp startDateTimestamp = order['startDate'];
                      DateTime startDate = startDateTimestamp.toDate();
                      return startDate.year == selectedDate!.year &&
                          startDate.month == selectedDate!.month &&
                          startDate.day == selectedDate!.day;
                    }).toList();
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Farmer')),
                        DataColumn(label: Text('Product')),
                        DataColumn(label: Text('Booking Date')),
                        DataColumn(label: Text('Return Date')),
                        DataColumn(label: Text('Rental Days')),
                        DataColumn(label: Text('Payment Status')),
                        DataColumn(label: Text('Amount')),
                      ],
                      rows: List.generate(filteredOrders.length, (index) {
                        QueryDocumentSnapshot completedData = filteredOrders[index];

                        // Format the startDate and endDate
                        Timestamp startDateTimestamp = completedData['startDate'];
                        Timestamp endDateTimestamp = completedData['endDate'];
                        String startDateFormatted = formatDate(startDateTimestamp);
                        String endDateFormatted = formatDate(endDateTimestamp);

                        // Get the details for the current row (farmer and machinery)
                        String farmerName = filteredDetails[index]['farmer']['name']!;
                        String machineryName = filteredDetails[index]['machinery']['name']!;

                        totalCompletedAmount += completedData['totalAmount'];

                        return DataRow(
                          cells: [
                            DataCell(
                              InkWell(
                                onTap: () {
                                  _showFarmerDetails(context, filteredDetails[index]['farmer']);
                                },
                                child: Text(farmerName),
                              ),
                            ),
                            DataCell(
                              InkWell(
                                onTap: () {
                                  _showMachineryDetails(context, filteredDetails[index]['machinery']);
                                },
                                child: Text(machineryName),
                              ),
                            ),
                            DataCell(Text(startDateFormatted)),
                            DataCell(Text(endDateFormatted)),
                            DataCell(Text(completedData['rentalDays']!.toString())),
                            DataCell(
                              Text(
                                completedData['paymentStatus']!
                                    .toString(),
                                style: TextStyle(
                                  color: completedData['paymentStatus']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                            DataCell(Text('₹${completedData['totalAmount']}')),
                          ],
                        );
                      }),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '₹$totalCompletedAmount',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Format date as 'dd/MM/yy'
  String formatDate(Timestamp timestamp) {
    DateFormat dateFormat = DateFormat('dd/MM/yy');
    return dateFormat.format(timestamp.toDate());
  }

  // Fetch farmer names and machinery details based on their ids
  Future<List<Map<String, dynamic>>> _fetchFarmerAndMachineryDetails(
      List<QueryDocumentSnapshot> rentalOrders) async {
    List<Map<String, dynamic>> details = [];

    for (var order in rentalOrders) {
      String farmerUid = order['uid'];
      String machineryId = order['machineryId'];

      // Fetch farmer details from the 'farmers' collection
      DocumentSnapshot farmerDoc =
          await FirebaseFirestore.instance.collection('farmers').doc(farmerUid).get();
      String farmerName = farmerDoc.exists ? farmerDoc['name'] ?? 'Unknown' : 'Unknown';
      String farmerEmail = farmerDoc.exists ? farmerDoc['email'] ?? 'Unknown' : 'Unknown';
      String farmerPhone = farmerDoc.exists ? farmerDoc['phone'] ?? 'Unknown' : 'Unknown';
      String farmerLocation = farmerDoc.exists ? farmerDoc['location'] ?? 'Unknown' : 'Unknown';
      String farmerProfileImageUrl = farmerDoc.exists ? farmerDoc['profileImageUrl'] ?? '' : '';

      // Fetch machinery details from the 'machinery' collection
      DocumentSnapshot machineryDoc =
          await FirebaseFirestore.instance.collection('machinary').doc(machineryId).get();
      String machineryName = machineryDoc.exists ? machineryDoc['name'] ?? 'Unknown' : 'Unknown';
      String machineryAvailability = machineryDoc.exists ? machineryDoc['availability'] ?? 'Unknown' : 'Unknown';
      String machineryDescription = machineryDoc.exists ? machineryDoc['description'] ?? 'Unknown' : 'Unknown';

      details.add({
        'farmer': {
          'name': farmerName,
          'email': farmerEmail,
          'phone': farmerPhone,
          'location': farmerLocation,
          'profileImageUrl': farmerProfileImageUrl,
        },
        'machinery': {
          'name': machineryName,
          'availability': machineryAvailability,
          'description': machineryDescription,
        },
      });
    }

    return details;
  }

  // Show Farmer details
  void _showFarmerDetails(BuildContext context, Map<String, dynamic> farmer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(farmer['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(farmer['profileImageUrl']),
              Text('Email: ${farmer['email']}'),
              Text('Phone: ${farmer['phone']}'),
              Text('Location: ${farmer['location']}'),
            ],
          ),
        );
      },
    );
  }

  // Show Machinery details
  void _showMachineryDetails(BuildContext context, Map<String, dynamic> machinery) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(machinery['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Availability: ${machinery['availability']}'),
              Text('Description: ${machinery['description']}'),
            ],
          ),
        );
      },
    );
  }

  // Search functionality for booking
  void _searchBooking(String query) {
    setState(() {
      filteredOrders = filteredOrders
          .where((order) => order['uid']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  // Open date picker
  Future<void> _selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(currentDate.year + 5),
    ) ?? currentDate;

    setState(() {
      selectedDate = pickedDate;
      _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    });
  }
}
