import 'dart:convert';

import 'package:flutter_recolectando_innomine/src/models/Rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id; //NULL SAFETY
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? sessiontoken;

  User(
      {this.id,
      this.email,
      this.name,
      this.lastname,
      this.phone,
      this.image,
      this.password,
      this.sessiontoken});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        sessiontoken: json["session_token"],
      );
  static List<User> fromJsonList(List<dynamic> jsonList) {
    List<User> toList = [];

    jsonList.forEach((item) {
      User users = User.fromJson(item);
      toList.add(users);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "session_token": sessiontoken
      };
}
