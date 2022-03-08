
import 'dart:convert';

NetworkModel networkModelFromJson(String str) => NetworkModel.fromJson(json.decode(str));

String networkModelToJson(NetworkModel data) => json.encode(data.toJson());

class NetworkModel {
    NetworkModel({
        this.name,
        this.id,
        this.capacidad,
    });

    String name;
    String id;
    String capacidad;

    factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json["name"].toString(),
        id: json["id"].toString(),
        capacidad: json["capacity"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "capacity": capacidad,
    };
}
