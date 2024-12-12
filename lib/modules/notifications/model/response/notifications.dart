// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Notifications notificationsFromJson(String str) =>
    Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    required this.notifications,
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
    required this.total,
  });

  final List<Notification> notifications;
  final int currentPage;
  final int perPage;
  final int lastPage;
  final int total;

  factory Notifications.initial() => Notifications(
        notifications: [],
        currentPage: 0,
        perPage: 0,
        lastPage: 0,
        total: 0,
      );

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "last_page": lastPage,
        "total": total,
      };
}

class Notification {
  Notification({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.body,
    required this.date,
  });

  final int id;
  final int senderId;
  final String senderName;
  final int receiverId;
  final String body;
  final DateTime date;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        senderId: json["sender_id"],
        senderName: json["sender_name"],
        receiverId: json["receiver_id"],
        body: json["body"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "sender_name": senderName,
        "receiver_id": receiverId,
        "body": body,
        "date": date.toIso8601String(),
      };
}
