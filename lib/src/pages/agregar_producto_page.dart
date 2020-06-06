import 'dart:io';

import 'package:eje5_login_firebase/src/modelos/modelo_producto.dart';
import 'package:eje5_login_firebase/src/servicios/firebase_conexion.dart';
import 'package:eje5_login_firebase/src/utilidades/utilidades.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaginaAgregarProductos extends StatefulWidget {
  const PaginaAgregarProductos({Key key}) : super(key: key);

  @override
  _PaginaAgregarProductosState createState() => _PaginaAgregarProductosState();
}

class _PaginaAgregarProductosState extends State<PaginaAgregarProductos> {
  final keyForm = GlobalKey<FormState>();
  final snackKey = GlobalKey<ScaffoldState>();
  final llamarFireBase = FirebaseDB();
  bool _cargando = false;
  File foto;
  PickedFile pikerFile;


  ModeloProductos producto = ModeloProductos();

  @override
  Widget build(BuildContext context) {
    final ModeloProductos prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: snackKey,
      appBar: AppBar(
        title: Text('Nuevo Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () => _galeriaCamara(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _galeriaCamara(ImageSource.camera),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Form(
              key: keyForm,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _ingresaNombreProd(context),
                  SizedBox(
                    height: 15.0,
                  ),
                  _ingresaPrecioProd(context),
                  SizedBox(
                    height: 15.0,
                  ),
                  _crearSwitchDisponible(),
                  SizedBox(
                    height: 15.0,
                  ),
                  _botonGuardarDatos(context),
                ],
              )),
        ),
      ),
    );
  }

  _ingresaNombreProd(BuildContext context) {
    return TextFormField(
      initialValue: producto.titulo,
      decoration: InputDecoration(
        labelText: 'Nombre Producto',
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: (valor) {
        if (valor.length < 3) {
          return 'Ingrese Nombre del Producto';
        } else {
          return null;
        }
      },
      onSaved: (valor) => producto.titulo = valor,
    );
  }

  _ingresaPrecioProd(BuildContext context) {
    return TextFormField(
      initialValue: producto.valor.toString(),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (valor) {
        if (esNumero(valor)) {
          return null;
        } else {
          return 'Solo Numero';
        }
      },
      onSaved: (valor) => producto.valor = double.parse(valor),
    );
  }

  _botonGuardarDatos(BuildContext context) {
    return RaisedButton.icon(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(12.0),
      shape: StadiumBorder(),
      icon: Icon(
        Icons.save_alt,
      ),
      label: Text('Guardar Producto'),
      textColor: Colors.white,
      onPressed: _cargando ? null : _enviarDatos,
    );
  }

  void _enviarDatos() async {
    setState(() {
      _cargando = true;
    });

    if (!keyForm.currentState.validate()) return null;

    keyForm.currentState.save();

    //Subida de la Imagen

    if (foto != null) {
      //cuando se resuelva el future devolvera la respuesta del url secure de la foto subida
      final resp = await llamarFireBase.subirImagen(File(foto.path));
      producto.fotoUrl = resp;
    }

    //Subida de datos firebase!
    if (producto.id == null) {
      llamarFireBase.crearNuevoProducto(producto);
      _mostrarSnackBar('Guardado Exitoso!');
    } else {
      llamarFireBase.modificarProducto(producto);
      _mostrarSnackBar('Cambio Guardado!');
    }

    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      _cargando = false;
      Navigator.pop(context);
    });
  }

  _crearSwitchDisponible() {
    return SwitchListTile(
      title: Text('Disponible: '),
      value: producto.disponible,
      onChanged: (valor) {
        setState(() {
          producto.disponible = valor;
        });
      },
    );
  }

  _mostrarSnackBar(String mensaje) {
    final snack = SnackBar(
      duration: Duration(milliseconds: 2500),
      content: Text(mensaje),
    );
    snackKey.currentState.showSnackBar(snack);
  }

  _galeriaCamara(ImageSource tipo) async {
    pikerFile = await ImagePicker().getImage(source: tipo);
    if( pikerFile != null ){
      foto = File(pikerFile.path);
      producto.fotoUrl= null;
    }else{
      foto = null;
    }
    setState(() {});
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/images/jar-loading.gif'),
        image: NetworkImage(producto.fotoUrl),
        fit: BoxFit.cover,
        height: 250.0,
      );
    } else {
      return Image(
        //pregunta si tiene informacion? y si tiene el path
        //si tiene el path pero es null ?? entonces usara la foto interna
        image: AssetImage(foto?.path ?? 'assets/images/no-image.png'),
        fit: BoxFit.cover,
        height: 250.0,
      );
    }
  }
}
