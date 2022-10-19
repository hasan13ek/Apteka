

  import 'dart:convert';

// List<YanaModel> drugsModelFromJson(String str) => List<YanaModel>.from(json.decode(str).map((x) => YanaModel.fromJson(x)));

  class YanaModel {
  YanaModel({
  this.id,
  this.name,
  this.description,
  this.imageUrl,
  this.price,
  this.quantity,
  });

  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? price;
  int? quantity;

  // factory YanaModel.fromJson(Map<String, dynamic> json) => YanaModel(
  // id: json["id"]??"",
  // name: json["name"]??"",
  // description: json["description"]??"",
  // imageUrl: json["imageUrl"],
  // price: json["price"]??"",
  // quantity: json["quantity"]??"",
  // );

  
  }