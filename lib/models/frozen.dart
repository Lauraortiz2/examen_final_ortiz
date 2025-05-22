// To parse this JSON data, do
//
//     final frozen = frozenFromMap(jsonString);

import 'dart:convert';

List<Frozen> frozenFromMap(String str) => List<Frozen>.from(json.decode(str).map((x) => Frozen.fromMap(x)));

String frozenToMap(List<Frozen> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Frozen {
    String id;
    String nom;
    String descripcio;
    String foto;
    String fechaNacimiento;
    String colorOjos;

    Frozen({
        required this.id,
        required this.nom,
        required this.descripcio,
        required this.foto,
        required this.fechaNacimiento,
        required this.colorOjos,
    });

    factory Frozen.fromMap(Map<String, dynamic> json) => Frozen(
        id: json["id"],
        nom: json["nom"],
        descripcio: json["descripcio"],
        foto: json["foto"],
        fechaNacimiento: json["fechaNacimiento"],
        colorOjos: json["colorOjos"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "descripcio": descripcio,
        "foto": foto,
        "fechaNacimiento": fechaNacimiento,
        "colorOjos": colorOjos,
    };
}
