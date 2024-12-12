// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

String messagesToJson(Messages data) => json.encode(data.toJson());


class Messages {
  Messages({
    required this.messages,
  });

  final List<Message> messages;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    required this.id,
    required this.date,
    required this.text,
    required this.title,
    required this.adminId,
  });

  final int id;
  final DateTime date;
  final String text;
  final String title;
  final int adminId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    text: json["text"],
    title: json["title"],
    adminId: json["admin_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "text": text,
    "title": title,
    "admin_id": adminId,
  };
}
