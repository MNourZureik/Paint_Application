import 'dart:convert';

class ClaimData{
  late int campaignId;
  late List<GiftData> gifts;

  ClaimData({
    this.campaignId=-1,
    this.gifts = const []
  });

  Map<String, dynamic> toJson() {
    // Convert selected gifts to a format suitable for JSON encoding
    List<Map<String, dynamic>> giftsJson = gifts.map((gift) => gift.toJson()).toList();

    return {
      "campaign_id": campaignId,
      "gifts": giftsJson,
    };
  }

  String parse(){
    return jsonEncode(toJson());
  }
}

class GiftData {
  late int id;
  late int quantity;

  GiftData({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }
}