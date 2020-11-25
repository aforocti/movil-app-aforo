// To parse this JSON data, do
//
//     final apModel = apModelFromJson(jsonString);

import 'dart:convert';

ApModel apModelFromJson(String str) => ApModel.fromJson(json.decode(str));

String apModelToJson(ApModel data) => json.encode(data.toJson());

class ApModel {

  ApModel({
    this.id,
    this.mac,
    this.model,
    this.name,
  });
  
  String id;
  String mac;
  String model;
  String name;

  factory ApModel.fromJson(Map<String, dynamic> json) => ApModel(
    id    : json["id"],
    mac   : json["mac"],
    model : json["model"],
    name  : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id"    : id,
    "mac"   : mac,
    "model" : model,
    "name"  : name,
  };

}
