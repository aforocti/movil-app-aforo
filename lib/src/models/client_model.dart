// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
    ClientModel({
        this.mac,
        this.apName,
        this.status,
    });

    String mac;
    String apName;
    String status;

    factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        mac    : json["mac"],
        apName : json["ap_name"],
        status : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "mac"     : mac,
        "ap_name" : apName,
        "status"  : status,
    };
}


// {
//   "mac": "94:7b:e7:32:f0:2a",
//   "ap_name": "Domo_Teleco1",
//   "status": "Associated"
// }