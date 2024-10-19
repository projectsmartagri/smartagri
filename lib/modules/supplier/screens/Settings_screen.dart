import 'package:flutter/material.dart';
import 'package:smartagri/modules/supplier/screens/Supplierhome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Account Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Notification Preferences'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPreferencesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacySettingsScreen()),
              );
            },
          ),
        
          ListTile(
            title: Text('Help & Support'),
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
        title: Text('Account Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Company Profile Section
          ListTile(
            title: Text('Company Profile'),
            subtitle: Text('Update company name, logo, and other details'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Company Profile Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CompanyProfileScreen()),
              );
            },
          ),
          Divider(),

          // Contact Information Section
          ListTile(
            title: Text('Contact Information'),
            subtitle: Text('Update business address, phone number, and email'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Contact Information Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactInformationScreen()),
              );
            },
          ),
          Divider(),

          // Account Preferences Section
          ListTile(
            title: Text('Account Preferences'),
            subtitle: Text('Set preferences for notifications and account privacy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Account Preferences Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPreferencesScreen()),
              );
            },
          ),
          Divider(),

          // Billing Information Section
          ListTile(
            title: Text('Billing Information'),
            subtitle: Text('Manage payment methods and view transaction history'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Billing Information Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BillingInformationScreen()),
              );
            },
          ),
          Divider(),

          // Security Settings Section
          ListTile(
            title: Text('Security Settings'),
            subtitle: Text('Change password and enable two-factor authentication'),
            trailing: Icon(Icons.arrow_forward_ios),
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
      appBar: AppBar(title: Text('Company Profile')),
      body: Center(child: Text('Update company profile details here')),
    );
  }
}

// Placeholder for the ContactInformationScreen
class ContactInformationScreen extends StatelessWidget {
  const ContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Information')),
      body: Center(child: Text('Update contact information here')),
    );
  }
}

// Placeholder for the AccountPreferencesScreen
class AccountPreferencesScreen extends StatelessWidget {
  const AccountPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Preferences')),
      body: Center(child: Text('Manage account preferences here')),
    );
  }
}

// Placeholder for the BillingInformationScreen
class BillingInformationScreen extends StatelessWidget {
  const BillingInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Billing Information')),
      body: Center(child: Text('Manage billing information here')),
    );
  }
}

// Placeholder for the SecuritySettingsScreen
class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Security Settings')),
      body: Center(child: Text('Update security settings here')),
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
        title: Text('Notification Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Rental Alerts'),
              subtitle: Text('Get notifications when your equipment is rented.'),
              value: _rentalAlerts,
              onChanged: (bool value) {
                setState(() {
                  _rentalAlerts = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Supplier Updates'),
              subtitle: Text('Receive updates from other suppliers.'),
              value: _supplierUpdates,
              onChanged: (bool value) {
                setState(() {
                  _supplierUpdates = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Machinery Availability Alerts'),
              subtitle: Text('Get notified when new machinery becomes available.'),
              value: _machineryAvailability,
              onChanged: (bool value) {
                setState(() {
                  _machineryAvailability = value;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save notification preferences
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Preferences saved successfully!'),
                  ),
                );
              },
              child: Text('Save Preferences'),
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
        title: Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your privacy settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Data Sharing'),
              subtitle: Text('Allow sharing of your data with other suppliers.'),
              value: _dataSharing,
              onChanged: (bool value) {
                setState(() {
                  _dataSharing = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Location Tracking'),
              subtitle: Text('Allow location tracking for better service and recommendations.'),
              value: _locationTracking,
              onChanged: (bool value) {
                setState(() {
                  _locationTracking = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Rental History Visibility'),
              subtitle: Text('Allow other suppliers to view your rental history.'),
              value: _rentalHistoryVisibility,
              onChanged: (bool value) {
                setState(() {
                  _rentalHistoryVisibility = value;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save privacy settings
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Privacy settings updated successfully!'),
                  ),
                );
              },
              child: Text('Save Settings'),
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
        title: Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions (FAQs)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
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
        style: TextStyle(fontWeight: FontWeight.bold),
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


