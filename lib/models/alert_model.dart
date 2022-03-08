
import 'dart:convert';

AlertModel wlcModelFromJson(String str) => AlertModel.fromJson(json.decode(str));

String wlcModelToJson(AlertModel data) => json.encode(data.toJson());

class AlertModel {
  String id;
  String networkId;
  String area;
  String deviceNumber;
  String date;
  String hour;
  String type;

  AlertModel({this.networkId, this.area, this.deviceNumber, this.hour, this.date, this.id, this.type});

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
    id           : json["id"].toString(),
    networkId    : json["network_id"].toString(),
    area         : json["area"].toString(),
    deviceNumber : json["device_number"].toString(),
    hour         : json["hour"].toString(),
    date         : json["date"].toString(),
    type         : json["type"].toString()
  );

  Map<String, dynamic> toJson() => {
    "id"            : id,
    "network_id"    : networkId,
    "area"          : area,
    "device_number" : deviceNumber,
    "hour"          : hour,
    "date"          : date,
    "type"          : type
  };
}

class Alerts {
  List<AlertModel> items = [];

  Alerts();

  Alerts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final alert = new AlertModel.fromJson(item);
      items.add(alert);
    }
  }
}
