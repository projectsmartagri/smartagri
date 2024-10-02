import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/home_screen.dart'; // Import HomeScreen

class OtherCompaniesScreen extends StatelessWidget {
  const OtherCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Companies'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Companies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16), // Space between title and list
            Expanded(
              child: ListView(
                children: [
                  _buildCompanyCard(
                    context,
                    'Mahindra',
                    'https://images.pexels.com/photos/281260/pexels-photo-281260.jpeg?cs=srgb&dl=pexels-francesco-ungaro-281260.jpg&fm=jpg', // Mahindra Logo
                  ),
                  _buildCompanyCard(
                    context,
                    'Kubota',
                    'https://img.freepik.com/free-photo/abstract-dark-blurred-background-smooth-gradient-texture-color-shiny-bright-website-pattern-banner-header-sidebar-graphic-art-image_1258-88597.jpg', // Kubota Logo
                  ),
                  _buildCompanyCard(
                    context,
                    'New Holland',
                    'https://t4.ftcdn.net/jpg/01/16/88/37/360_F_116883786_wuckft1sNw1ouQfJ6FuquZnxea3qBlxy.jpg', // New Holland Logo
                  ),
                  _buildCompanyCard(
                    context,
                    'Swaraj',
                    'https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-background-website-template-frame-business-report_1258-52616.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1727740800&semt=ais_hybrid', // Swaraj Logo
                  ),
                  // Add more company cards here...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context, String companyName, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay with company name
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Black overlay with transparency
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              companyName,
              style: TextStyle(
                fontSize: 29, // Increased font size for better visibility
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
