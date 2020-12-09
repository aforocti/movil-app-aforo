
import 'dart:convert';

ApModel wlcModelFromJson(String str) => ApModel.fromJson(json.decode(str));

String wlcModelToJson(ApModel data) => json.encode(data.toJson());

class ApModel {
  
  String wlcId;
  String mac;
  String model;
  String name;
  String piso;
  String devices;
  String limit;

  ApModel({this.wlcId, this.mac, this.model, this.name, this.piso, this.devices, this.limit});

  factory ApModel.fromJson(Map<String, dynamic> json) => ApModel(
    wlcId   : json["wlc_id"],
    mac     : json["mac"],
    model   : json["model"],
    name    : json["name"],
    piso    : json["piso"],
    devices : json["devices"],
    limit   : json["limit"]
  );

  Map<String, dynamic> toJson() => {
    "network_id" : wlcId,
    "mac"        : mac,
    "model"      : model,
    "name"       : name,
    "piso"       : piso,
    "devices"    : devices,
    "limit"      : limit
  };
}

class Aps {
  List<ApModel> items = new List();

  Aps();

  Aps.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final ap = new ApModel.fromJson(item);
      items.add(ap);
    }
  }
}
