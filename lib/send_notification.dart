import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendNotificationToDevice(String title, String body,List playerIds) async {
    const String oneSignalRestApiKey =
        'os_v2_app_qxs76lg24rh3fml72ng3mijcftys6xqsujbeu3m5cgtcpxpv3s54kel25jkiwpmjqlcdhqm7znxy6wo4etj4zvkzf32lnedl5uyj2dq';
    const String oneSignalAppId = '85e5ff2c-dae4-4fb2-b17f-d34db621222c';


   

    
    var url = Uri.parse('https://api.onesignal.com/notifications?c=push');
    var notificationData = {
      "app_id": oneSignalAppId,
      "headings": {"en": title},
      "contents": {"en": body},
      "target_channel": "push",
      "include_player_ids": playerIds
    };
    print('hhhh');
    var headers = {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Basic $oneSignalRestApiKey",
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(notificationData),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("Notification Sent Successfully!");
        print(response.body);
      } else {
        print("Failed to send notification: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }