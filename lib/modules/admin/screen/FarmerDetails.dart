import 'package:flutter/material.dart';

class FarmerDetails extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String farmerIdUrl;
  final bool isApproved;  // Add a field to track whether the farmer is approved

  const FarmerDetails({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.farmerIdUrl,
    required this.isApproved,  // Pass isApproved in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 39, 156, 68),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Farmer Information',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 135, 74),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: name,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: email,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: phone,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Location',
                        value: location,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Farmer ID: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      farmerIdUrl.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _showFullScreenImage(context, farmerIdUrl);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  farmerIdUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      'Failed to load ID image.',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const Text(
                              'No ID image available.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Display Accept/Reject buttons if farmer is not approved
              if (!isApproved) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      context,
                      label: 'Accept',
                      icon: Icons.check,
                      color: const Color.fromARGB(255, 28, 168, 63),
                      onPressed: () async {
                        // Call function to approve the farmer
                        await _updateFarmerStatus('farmerId', true); // Use actual farmerId
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Farmer Accepted')),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildActionButton(
                      context,
                      label: 'Reject',
                      icon: Icons.close,
                      color: Colors.red.shade600,
                      onPressed: () async {
                        // Call function to reject the farmer
                        await _updateFarmerStatus('farmerId', false); // Use actual farmerId
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Farmer Rejected')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color.fromARGB(255, 27, 143, 38), size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  // Simulated function to update the farmer's approval status
  Future<void> _updateFarmerStatus(String farmerId, bool isApproved) async {
    // Code to update the farmer's approval status in Firebase or backend goes here
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
