import 'dart:convert';

Xodimlar xodimlarFromJson(String str) => Xodimlar.fromJson(json.decode(str));

String xodimlarToJson(Xodimlar data) => json.encode(data.toJson());

class Xodimlar {
  String token;
  String ismi;
  int tel;

  Xodimlar({
    required this.token,
    required this.ismi,
    required this.tel,
  });

  factory Xodimlar.fromJson(Map<String, dynamic> json) => Xodimlar(
        token: json["token"],
        ismi: json["ismi"],
        tel: json["tel"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "ismi": ismi,
        "tel": tel,
      };
}
