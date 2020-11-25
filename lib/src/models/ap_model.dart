// To parse this JSON data, do
//
//     final apModel = apModelFromJson(jsonString);

import 'dart:convert';

ApModel apModelFromJson(String str) => ApModel.fromJson(json.decode(str));

String apModelToJson(ApModel data) => json.encode(data.toJson());

class ApModel {
    ApModel({
        this.macId,
        this.model,
        this.name,
    });

    String macId;
    String model;
    String name;

    factory ApModel.fromJson(Map<String, dynamic> json) => ApModel(
        macId: json["mac_id"],
        model: json["model"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "mac_id": macId,
        "model": model,
        "name": name,
    };
}
