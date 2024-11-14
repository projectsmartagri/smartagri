import 'package:flutter/material.dart';

class ChooseScreen extends StatelessWidget {
  ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Module'),
        backgroundColor: Colors.teal, // Match the green color in the image
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ModuleButton(
                  moduleName: 'Farmer',
                  icon: Icons.agriculture, // Use appropriate icons
                  onTap: () {
                    // Navigate to Farmer module screen
                  },
                ),
                ModuleButton(
                  moduleName: 'User',
                  icon: Icons.person, // Use appropriate icons
                  onTap: () {
                    // Navigate to User module screen
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ModuleButton(
                  moduleName: 'Supplier',
                  icon: Icons.local_shipping, // Use appropriate icons
                  onTap: () {
                    // Navigate to Supplier module screen
                  },
                ),
                ModuleButton(
                  moduleName: 'Admin',
                  icon: Icons.admin_panel_settings, // Use appropriate icons
                  onTap: () {
                    // Navigate to Admin module screen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModuleButton extends StatelessWidget {
  final String moduleName;
  final IconData icon;
  final VoidCallback onTap;

  const ModuleButton({
    required this.moduleName,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Colors.teal,
                ),
                SizedBox(height: 8.0),
                Text(
                  moduleName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
