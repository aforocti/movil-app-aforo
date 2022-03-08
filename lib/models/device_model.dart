import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
    DeviceModel({
        this.networkId,
        this.token,
    });

    String networkId;
    String token;

    factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        networkId: json["network_id"].toString(),
        token: json["token"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "network_id": networkId,
        "token": token,
    };
}
