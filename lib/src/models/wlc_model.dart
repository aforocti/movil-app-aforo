// To parse this JSON data, do
//
//     final wlcModel = wlcModelFromJson(jsonString);

import 'dart:convert';

WlcModel wlcModelFromJson(String str) => WlcModel.fromJson(json.decode(str));

String wlcModelToJson(WlcModel data) => json.encode(data.toJson());

class WlcModel {
    WlcModel({
        this.macId,
        this.manufacturerName,
        this.productName,
    });

    String macId;
    String manufacturerName;
    String productName;

    factory WlcModel.fromJson(Map<String, dynamic> json) => WlcModel(
        macId: json["mac_id"],
        manufacturerName: json["manufacturer_name"],
        productName: json["product_name"],
    );

    Map<String, dynamic> toJson() => {
        "mac_id": macId,
        "manufacturer_name": manufacturerName,
        "product_name": productName,
    };
}
