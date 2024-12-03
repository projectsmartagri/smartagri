import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupplierHomeScreen()),
            ); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Account Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Notification Preferences'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPreferencesScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacySettingsScreen()),
              );
            },
          ),
        
          ListTile(
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpAndSupportScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}









// AccountSettingsScreen
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Company Profile Section
          ListTile(
            title: const Text('Company Profile'),
            subtitle: const Text('Update company name, logo, and other details'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Company Profile Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CompanyProfileScreen()),
              );
            },
          ),
          const Divider(),

          // Contact Information Section
          ListTile(
            title: const Text('Contact Information'),
            subtitle: const Text('Update business address, phone number, and email'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Contact Information Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactInformationScreen()),
              );
            },
          ),
          const Divider(),

          // Account Preferences Section
          ListTile(
            title: const Text('Account Preferences'),
            subtitle: const Text('Set preferences for notifications and account privacy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Account Preferences Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPreferencesScreen()),
              );
            },
          ),
          const Divider(),

          // Billing Information Section
          ListTile(
            title: const Text('Billing Information'),
            subtitle: const Text('Manage payment methods and view transaction history'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Billing Information Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BillingInformationScreen()),
              );
            },
          ),
          const Divider(),

          // Security Settings Section
          ListTile(
            title: const Text('Security Settings'),
            subtitle: const Text('Change password and enable two-factor authentication'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Security Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecuritySettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder for the CompanyProfileScreen
class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Profile')),
      body: const Center(child: Text('Update company profile details here')),
    );
  }
}

// Placeholder for the ContactInformationScreen
class ContactInformationScreen extends StatelessWidget {
  const ContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Information')),
      body: const Center(child: Text('Update contact information here')),
    );
  }
}

// Placeholder for the AccountPreferencesScreen
class AccountPreferencesScreen extends StatelessWidget {
  const AccountPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Preferences')),
      body: const Center(child: Text('Manage account preferences here')),
    );
  }
}

// Placeholder for the BillingInformationScreen
class BillingInformationScreen extends StatelessWidget {
  const BillingInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing Information')),
      body: const Center(child: Text('Manage billing information here')),
    );
  }
}

// Placeholder for the SecuritySettingsScreen
class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Settings')),
      body: const Center(child: Text('Update security settings here')),
    );
  }
}






// NotificationPreferencesScreen
class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  _NotificationPreferencesScreenState createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  bool _rentalAlerts = true;
  bool _supplierUpdates = false;
  bool _machineryAvailability = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Rental Alerts'),
              subtitle: const Text('Get notifications when your equipment is rented.'),
              value: _rentalAlerts,
              onChanged: (bool value) {
                setState(() {
                  _rentalAlerts = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Supplier Updates'),
              subtitle: const Text('Receive updates from other suppliers.'),
              value: _supplierUpdates,
              onChanged: (bool value) {
                setState(() {
                  _supplierUpdates = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Machinery Availability Alerts'),
              subtitle: const Text('Get notified when new machinery becomes available.'),
              value: _machineryAvailability,
              onChanged: (bool value) {
                setState(() {
                  _machineryAvailability = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save notification preferences
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Preferences saved successfully!'),
                  ),
                );
              },
              child: const Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}







// PrivacySettingsScreen

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _dataSharing = true;
  bool _locationTracking = false;
  bool _rentalHistoryVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your privacy settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Data Sharing'),
              subtitle: const Text('Allow sharing of your data with other suppliers.'),
              value: _dataSharing,
              onChanged: (bool value) {
                setState(() {
                  _dataSharing = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Location Tracking'),
              subtitle: const Text('Allow location tracking for better service and recommendations.'),
              value: _locationTracking,
              onChanged: (bool value) {
                setState(() {
                  _locationTracking = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Rental History Visibility'),
              subtitle: const Text('Allow other suppliers to view your rental history.'),
              value: _rentalHistoryVisibility,
              onChanged: (bool value) {
                setState(() {
                  _rentalHistoryVisibility = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save privacy settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Privacy settings updated successfully!'),
                  ),
                );
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}








// HelpAndSupportScreen

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions (FAQs)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _faqTile('How do I create an account?', 'You can create an account by clicking on the sign-up button on the homepage.'),
            _faqTile('How do I rent equipment?', 'To rent equipment, navigate to the equipment section and select the items you wish to rent.'),
            _faqTile('What payment methods are accepted?', 'We accept various payment methods including credit cards and bank transfers.'),
           
          ],
        ),
      ),
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}


