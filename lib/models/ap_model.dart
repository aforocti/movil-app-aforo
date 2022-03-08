import 'dart:convert';

ApModel wlcModelFromJson(String str) => ApModel.fromJson(json.decode(str));

String wlcModelToJson(ApModel data) => json.encode(data.toJson());

class ApModel {
  String wlcId;
  String networkId;
  String mac;
  String model;
  String name;
  String piso;
  String devices;
  String limit;
  String active;
  String dx;
  String dy;

  ApModel({
    this.wlcId,
    this.networkId,
    this.mac,
    this.model,
    this.name,
    this.piso,
    this.devices,
    this.limit,
    this.active,
    this.dx,
    this.dy,
  });

  factory ApModel.fromJson(Map<String, dynamic> json) {
    return ApModel(
        wlcId: json["wlc_id"].toString(),
        networkId: json["network_id"].toString(),
        mac: json["mac"].toString(),
        model: json["model"].toString(),
        name: json["name"].toString(),
        piso: json["piso"].toString(),
        devices: json["devices"].toString(),
        limit: json["limit"].toString(),
        active: json["active"].toString(),
        dx: json["dx"].toString(),
        dy: json["dy"].toString()
    );
  }

  Map<String, dynamic> toJson() => {
    "wlc_id": wlcId,
    "network_id": networkId,
    "mac": mac,
    "model": model,
    "name": name,
    "piso": piso,
    "devices": devices,
    "limit": limit,
    "active": active,
    "dx": dx,
    "dy": dy,
  };
}

class Aps {
  List<ApModel> items = [];

  Aps();

  Aps.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var json in jsonList) {
      var ap = new ApModel.fromJson(json);
      items.add(ap);
    }
  }
}
