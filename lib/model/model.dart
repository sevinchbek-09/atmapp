// To parse this JSON data, do
//
//     final murojaat = murojaatFromJson(jsonString);

import 'dart:convert';

Murojaat murojaatFromJson(String str) => Murojaat.fromJson(json.decode(str));

String murojaatToJson(Murojaat data) => json.encode(data.toJson());

class Murojaat {
  String matn;
  String bino;
  String xona;
  String bulim;
  String tel;
  bool status;

  Murojaat({
    required this.matn,
    required this.bino,
    required this.xona,
    required this.bulim,
    required this.tel,
    required this.status,
  });

  factory Murojaat.fromJson(Map<String, dynamic> json) => Murojaat(
    matn: json["matn"],
    bino: json["bino"],
    xona: json["xona"],
    bulim: json["bulim"],
    tel: json["tel"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "matn": matn,
    "bino": bino,
    "xona": xona,
    "bulim": bulim,
    "tel": tel,
    "status": status,
  };
}
