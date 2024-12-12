import 'dart:convert';

class SendMessageData {
  final String phoneNumber;
  final String name;
  final String mtype;
  final String destination;
  final String text;
  final List<String> recievers;

  SendMessageData(
      {required this.phoneNumber,
        required this.name,
        required this.mtype,
        required this.destination,
        required this.text,
        required this.recievers});

  Map<String, dynamic> toJson() => {
    "sender_name":name,
    "phone_number":phoneNumber,
    "mtype":mtype,
    "destination":destination,
    "text":text,
    "receivers":"$recievers",
  };

  String parse() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'SendMessageData{phoneNumber: $phoneNumber, name: $name, mtype: $mtype, destination: $destination, text: $text, receivers: $recievers}';
  }
}
class SendMessageDataByMember {

  final String mtype;
  final String destination;
  final String text;
  List<String> recievers;

  SendMessageDataByMember(
      {
        required this.mtype,
        required this.destination,
        required this.text,
        required this.recievers});

  Map<String, dynamic> toJson() => {
    "mtype":mtype,
    "destination":destination,
    "text":text,
    "receivers":"$recievers",
  };

  String parse() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'SendMessageDataByMember{mtype: $mtype, destination: $destination, text: $text, recievers: $recievers}';
  }
}