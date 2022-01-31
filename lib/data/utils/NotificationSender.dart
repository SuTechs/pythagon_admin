import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:pythagon_admin/data/utils/modal/collectionRef.dart';
import 'package:pythagon_admin/widgets/showToast.dart';

class NotificationModal {
  // info
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final String from;
  final String to;

  // notification
  final String title;
  final String body;

  // data

  final Map<String, dynamic>? data;

  NotificationModal({
    required this.from,
    required this.to,
    required this.title,
    required this.body,
    this.data,
  });

  void send(List<String> tokens, {bool isPythagonTopic = false}) {
    // save notification
    CollectionRef.notifications.doc(id).set({
      'id': id,
      'from': from,
      'to': to,
      "title": title,
      "body": body,
      "isRead": false,
      "createdAt": Timestamp.now(),
      if (data != null) "data": data,
    });

    // notification body
    final b = {
      // to
      if (isPythagonTopic)
        "to": "/topics/pythagon"
      else if (tokens.length == 1)
        "to": tokens.first
      else
        'registration_ids': tokens,

      // notification
      "notification": {"title": title, "body": body},

      // data
      // "data": {
      //   'notification_id': id,
      //   'notification_from': from,
      //   'notification_to': to,
      //   if (data != null) "otherData": data,
      // },
      "data": data,
    };

    // send notification
    http
        .post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(b),
      headers: _headers,
    )
        .then((response) {
      print('Response = ${response.body}');
      if (response.statusCode == 200)
        showToast('Notifications Sent!');
      else {
        showToast(response.body);
        print(response.reasonPhrase);
      }
    });
  }
}

const _headers = {
  'Authorization':
      'key=AAAAYWh0-Pk:APA91bHbUlzaOqWIQaaHKrqXrwn6TM_cnQwqV8Ny6X4hjDhJzm41v-lhzw7CkAyPo2IUNrze84Fi-0VyO-lqUxDnupidz-s0ixXZmZMEF6ch7VsEcBgxxPnY4tJuhkCzHBwvmuYoSrUy',
  'Content-Type': 'application/json'
};
