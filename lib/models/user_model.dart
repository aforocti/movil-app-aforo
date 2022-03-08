
import 'dart:convert';

UserModel networkModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String networkModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.user,
        this.networkId,
    });

    String user;
    String networkId;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["user"].toString(),
        networkId: json["network_id"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "network_id": networkId,
    };
}
