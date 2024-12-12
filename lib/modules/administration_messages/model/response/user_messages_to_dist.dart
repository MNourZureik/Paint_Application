// To parse this JSON data, do
//
//     final userMessagesToDist = userMessagesToDistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserMessagesToDist userMessagesToDistFromJson(String str) => UserMessagesToDist.fromJson(json.decode(str));

String userMessagesToDistToJson(UserMessagesToDist data) => json.encode(data.toJson());

class UserMessagesToDist {
  UserMessagesToDist({
    required this.messages,
  });

  final List<Message> messages;

  factory UserMessagesToDist.fromJson(Map<String, dynamic> json) => UserMessagesToDist(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    required this.senderName,
    required this.phoneNumber,
    required this.mtype,
    required this.destination,
    required this.receivers,
    required this.text,
    required this.date,
    required this.stype,
    required this.senderId,
  });

  final String senderName;
  final String phoneNumber;
  final String mtype;
  final String destination;
  final String receivers;
  final String text;
  final DateTime date;
  final String stype;
  final String senderId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    senderName: json["sender_name"],
    phoneNumber: json["phone_number"],
    mtype: json["mtype"],
    destination: json["destination"],
    receivers: json["receivers"],
    text: json["text"],
    date: DateTime.parse(json["date"]),
    stype: json["stype"],
    senderId: json["sender_id"]??"0",
  );

  Map<String, dynamic> toJson() => {
    "sender_name": senderName,
    "phone_number": phoneNumber,
    "mtype": mtype,
    "destination": destination,
    "receivers": receivers,
    "text": text,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "stype": stype,
    "sender_id": senderId,
  };
}
