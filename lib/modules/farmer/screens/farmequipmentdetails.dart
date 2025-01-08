import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smartagri/modules/farmer/screens/homepage_screen.dart';

class EquipmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> machinery;
  final String id;

  const EquipmentDetailsScreen({super.key, required this.machinery, required this.id});

  @override
  _EquipmentDetailsScreenState createState() => _EquipmentDetailsScreenState();
}

class _EquipmentDetailsScreenState extends State<EquipmentDetailsScreen> {
  late Razorpay _razorpay;

  String ? supplierName;
  String? supplierAddress;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    fetchSupplierName(widget.machinery['userid']);
  }



  Future<void> fetchSupplierName(String supplierId) async {
    try {
      final supplierData = await getSupplierData(supplierId);
      if (supplierData != null) {
        setState(() {
          supplierName = supplierData['name'];
          supplierAddress = supplierData['address'];
          phoneNumber = supplierData['phone'];
        });
      }
    } catch (e) {
      print('Error fetching supplier name: $e');
    }
  }

  Future<Map<String, dynamic>?> getSupplierData(String supplierId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('suppliers') // Replace with your supplier collection name
          .doc(supplierId)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      }
    } catch (e) {
      print('Error fetching supplier data: $e');
    }
    return null;
  }


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  // Function to initialize Razorpay payment

  void _openCheckout(double amount, [Function(String paymentId)? onSuccess]) async {
  var options = {
    'key': 'rzp_test_QLvdqmBfoYL2Eu', // Replace with your Razorpay key
    'amount': (amount * 100).toInt(), // Convert amount to paise
    'name': 'Machinery Booking',
    'description': 'Payment for machinery rental',
    'prefill': {
      'contact': '1234567890', // Add user phone number here if available
      'email': 'user@example.com', // Add user email here if available
    },
  };

  try {
    _razorpay.open(options);
   
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {


        if(onSuccess == null){
          _handlePaymentSuccess(response);
        }else{
          onSuccess(response.paymentId);
        }
      });
      
  
    
  } catch (e) {
    print('Error: $e');
  }
}








  // Handle successful payment
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    _processOrder(paymentId:response.paymentId!);
  }

  // Handle failed payment
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Failed: ${response.code} - ${response.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  // Handle payment cancellation
  void _handlePaymentCancel(dynamic response) {
    print('Payment Cancelled: ${response.paymentId}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment cancelled')),
    );
  }

   String formatTimestamp(DateTime timestamp) {

    return DateFormat('MMMM dd, yyyy').format(timestamp); // Example: December 12, 2024 - 02:30 PM
  }

  // Process the order after successful payment
  Future<void> _processOrder({required String paymentId}) async {
    try {
     
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to proceed.')),
        );
        return;
      }

      // Save order data to Firestore
      final orderData = {
        'machineryId': widget.id,
        'supplierId': widget.machinery['userid'],
        'uid': userId,
        'bookedAt': FieldValue.serverTimestamp(),
        'paymentStatus': true, // Set payment status to true after payment
        'rentalDays': rentalDays,
        'totalAmount': totalAmount,
        'startDate': currentDate,
        'endDate': endDate,
        'isDeliverd' : false,
        'isReturn' :  false,
        'quantity' : quantity,
        'paymentId': paymentId, // Store Razorpay payment ID
      };

      await FirebaseFirestore.instance.collection('rental_order').add(orderData);

    

      await FirebaseFirestore.instance.collection('machinary').doc(widget.id).get().then((docSnapshot) {
  if (docSnapshot.exists) {
    int currentQuantity = docSnapshot['Quantity'];

    if (currentQuantity <= 0) {
      // Set availability to "Not Available" if quantity is zero
      FirebaseFirestore.instance.collection('machinary').doc(widget.id).update({
        'availability': 'Not Available',
      });
    }
  }
});

      // Close loading dialog
      Navigator.pop(context);

      // Show success popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          content: Text(
            'Successfully booked ${widget.machinery['name']} for $rentalDays days. '
            '\nTotal: ₹$totalAmount\nStart Date: ${formatTimestamp(currentDate!)}\nEnd Date: ${formatTimestamp(endDate!)}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FarmerHomeScreen(),), (route) => false,);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book. Error: $e')),
      );
    }
  }

   int ? rentalDays;

num  ?totalAmount;
DateTime  ? currentDate; 
DateTime ?endDate;


  void makeSuccessOrder() async {
  // Check if the machinery is already booked
  final existingOrder = await FirebaseFirestore.instance
      .collection('rental_order')
      .where('machineryId', isEqualTo: widget.id)
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .get();


  if (existingOrder.docs.isNotEmpty) {

    // Machinery already booked, prompt for extension
    final doc = existingOrder.docs.first;
    int additionalDays = await _showDaysDialog(context,true);

    if (additionalDays == 0 || additionalDays == null) return;

    final existingEndDate = (doc['endDate'] as Timestamp).toDate();
    final newEndDate = existingEndDate.add(Duration(days: additionalDays));
    final additionalAmount = additionalDays * widget.machinery['price'];

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Process additional payment
    _openCheckout(additionalAmount.toDouble(), (paymentId) async {
      // Update existing order with new details
      await FirebaseFirestore.instance
          .collection('rental_order')
          .doc(doc.id)
          .update({
        'endDate': newEndDate,
        'extendeddays' : additionalDays,
        'totalAmount': doc['totalAmount'] + additionalAmount,
      });

      // Close loading dialog
      Navigator.pop(context);

      // Show success popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          content: Text(
            'Successfully extended the booking for ${widget.machinery['name']} by $additionalDays days.\n'
            'New End Date: ${newEndDate.toLocal()}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerHomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
    return;
  }



  // Normal booking flow if not already booked
  rentalDays = await _showDaysDialog(context); 
  if (rentalDays == 0 || rentalDays == null) return;

  totalAmount = rentalDays! * widget.machinery['price'];
  currentDate = DateTime.now();
  endDate = currentDate!.add(Duration(days: rentalDays!));

  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  _openCheckout(totalAmount!.toDouble());
}
  int quantity = 0;
  Future<int> _showDaysDialog(BuildContext context, [bool isExtended = false]) async {
  int selectedDays = 0;
  bool isAgreementAccepted = false;


  return await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: isExtended
                ? Text('Extend Rental Days')
                : const Text('Select Rental Days'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isExtended)
                  Text('You are already booked this machine. Want to extend? Fill in the details below.'),
                Text(
                  'Price per day: ₹${widget.machinery['price']}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter number of days',
                  ),
                  onChanged: (value) {
                    selectedDays = int.tryParse(value) ?? 0;
                  },
                ),
                const SizedBox(height: 16),
                  TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter the quantity',
                  ),
                  onChanged: (value) {
                    
                    quantity = int.tryParse(value) ?? 0;
                  },
                ),
                                const SizedBox(height: 16),

                Row(
                  children: [
                    Checkbox(
                      value: isAgreementAccepted,
                      onChanged: (value) {
                        setState(() {
                          isAgreementAccepted = value ?? false;
                        });
                      },
                    ),
                    const Text('Accept User Agreement'),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Rental Agreement'),
                            content: const Text(
                              '1. The equipment must be returned in good condition.\n'
                              '2. Late returns will incur additional charges.\n'
                              '3. The renter is responsible for any damage during the rental period.\n'
                              '4. Payment must be completed before taking possession of the equipment.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'View Agreement',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (!isAgreementAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please accept the user agreement')),
                    );
                    return;
                  }

                  if(widget.machinery['Quantity'] < quantity){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Quantity exceeded')),
                    );
                    return;

                  }
                  Navigator.of(context).pop(selectedDays);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
  ) ?? 0;
}

   @override
  Widget build(BuildContext context) {
    print(widget.machinery['userid']);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Equipment Details',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 6,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Machinery Image
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.machinery['image'],
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Machinery Name and Price Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Company name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      
                      Expanded(

                        child: Text(
                          supplierName ?? 'loading....',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        supplierAddress ?? 'loading....',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        phoneNumber ?? 'loading....',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.machinery['name'],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),


                  Text(
                    widget.machinery['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),
                  Row(
                    children: [
                      Text(
                        'Rent/day',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '₹${widget.machinery['price']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),

                  if( widget.machinery['availability'] == "Available")

                  Row(
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 18,
                 
                       
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.machinery['Quantity']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if( widget.machinery['availability'] == "Available")
                  Divider(color: Colors.grey.shade300, thickness: 1, height: 30),
                  // Availability Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.machinery['availability'] == "Available"
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: widget.machinery['availability'] == "Available"
                            ? Colors.green
                            : Colors.red,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.machinery['availability'] == "Available"
                            ? 'Available'
                            : 'Not Available',
                        style: TextStyle(
                          fontSize: 18,
                          color: widget.machinery['availability'] == "Available"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Book Now Button
            if (widget.machinery['availability'] == "Available")
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () async{
                          makeSuccessOrder();
                        
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 8,
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }



}