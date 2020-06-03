
import 'dart:convert';
//decode descodifica
ModeloProductos modeloProductosFromJson(String str) => ModeloProductos.fromJson(json.decode(str));

String modeloProductosToJson(ModeloProductos data) => json.encode(data.toJson());//codifica

class ModeloProductos {
    ModeloProductos({
        this.id,
        this.titulo = '',
        this.valor = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    factory ModeloProductos.fromJson(Map<String, dynamic> json) => ModeloProductos(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"].toDouble(),
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
  //      "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}
