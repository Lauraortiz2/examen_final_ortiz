import 'dart:convert';

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

    factory Frozen.fromJson(String str) => Frozen.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

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
