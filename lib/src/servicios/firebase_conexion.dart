import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:eje5_login_firebase/src/modelos/modelo_producto.dart';
export 'package:eje5_login_firebase/src/modelos/modelo_producto.dart';
import 'package:http/http.dart' as http;

class FirebaseDB {
  final String _url = 'https://flutter-varios-df896.firebaseio.com';

  Future<bool> crearNuevoProducto(ModeloProductos producto) async {
    final url = '$_url/productos.json';
    //enviando a firebase
    final resEnviada =
        await http.post(url, body: modeloProductosToJson(producto));

    //Borrar despues
    //final datosDecodificados = await json.decode(resEnviada.body);

    //print(datosDecodificados);

    return true;
  }

  Future<List<ModeloProductos>> recibirProductos() async {
    final String url = '$_url/productos.json';

    final respRecibida = await http.get(url);

    final Map<String, dynamic> datosDecodificado =
        json.decode(respRecibida.body);

    if (datosDecodificado == null) return [];

    final List<ModeloProductos> productos = List();

    datosDecodificado.forEach((id, prod) {
      final prodTemporal = ModeloProductos.fromJson(prod);
      prodTemporal.id = id;

      productos.add(prodTemporal);
    });

    return productos;
  }

  Future<int> eliminarProductosDB(String id) async {
    final String url = '$_url/productos/$id.json';

    await http.delete(url);

    return 1;
  }

  Future<bool> modificarProducto(ModeloProductos producto) async {
    final url = '$_url/productos/${producto.id}.json';
    //enviando a firebase
    final resEnviada =
        await http.put(url, body: modeloProductosToJson(producto));

    return true;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dravhy9u7/image/upload?upload_preset=wqgmfje3');
    final tipoMime = mime(imagen.path).split('/'); //image/jpg

    final peticionCargaImagen = http.MultipartRequest('POST', url);

    final archivo = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(tipoMime[0], tipoMime[1])
    );

    peticionCargaImagen.files.add(archivo);

    //ejecutar peticion.

    final respuesta = await peticionCargaImagen.send();
    final resultado = await http.Response.fromStream(respuesta);

    if(resultado.statusCode != 200 && resultado.statusCode != 200){

      print('Te mamaste en el codigo!');
      print(resultado.body);
      return null;
    }

    final respuestaDecodificada = json.decode(resultado.body);
    print(respuestaDecodificada);
    return respuestaDecodificada['secure_url'];
  }
}
