// To parse this JSON data, do
//
//     final premios = premiosFromJson(jsonString);

import 'dart:convert';

Premios? premiosFromJson(String str) => Premios.fromJson(json.decode(str));

String premiosToJson(Premios? data) => json.encode(data!.toJson());

class Premios {
  String? id;
  String? nombre;
  String? cantidadPuntos;
  String? imagen;

  Premios({
    this.id,
    this.nombre,
    this.cantidadPuntos,
    this.imagen,
  });

  factory Premios.fromJson(Map<String, dynamic> json) => Premios(
        id: json["id"],
        nombre: json["nombre"],
        cantidadPuntos: json["cantidad_puntos"],
        imagen: json["imagen"],
      );
  static List<Premios> fromJsonList(List<dynamic> jsonList) {
    List<Premios> toList = [];

    jsonList.forEach((item) {
      Premios premios = Premios.fromJson(item);
      toList.add(premios);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "cantidad_puntos": cantidadPuntos,
        "imagen": imagen,
      };
}
