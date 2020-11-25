// To parse this JSON data, do
//
//     final wlcModel = wlcModelFromJson(jsonString);

import 'dart:convert';

WlcModel wlcModelFromJson(String str) => WlcModel.fromJson(json.decode(str));

String wlcModelToJson(WlcModel data) => json.encode(data.toJson());

class WlcModel {

  WlcModel({
    this.id,
    this.mac,
    this.manufacturerName,
    this.productName,
    this.aps
  });

  String id;
  String mac;
  String manufacturerName;
  String productName;
  List   aps;

  factory WlcModel.fromJson(Map<String, dynamic> json) => WlcModel(
    id               : json["id"],
    mac              : json["mac"],
    manufacturerName : json["manufacturer_name"],
    productName      : json["product_name"],
    aps              : json["aps"],
  );

  Map<String, dynamic> toJson() => {
    "id"                : id,
    "mac"               : mac,
    "manufacturer_name" : manufacturerName,
    "product_name"      : productName,
    "aps"               : aps,
  };

}
