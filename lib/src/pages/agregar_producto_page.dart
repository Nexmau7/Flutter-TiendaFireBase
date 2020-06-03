import 'package:eje5_login_firebase/src/modelos/modelo_producto.dart';
import 'package:eje5_login_firebase/src/servicios/firebase_conexion.dart';
import 'package:eje5_login_firebase/src/utilidades/utilidades.dart';
import 'package:flutter/material.dart';

class PaginaAgregarProductos extends StatefulWidget {
  const PaginaAgregarProductos({Key key}) : super(key: key);

  @override
  _PaginaAgregarProductosState createState() => _PaginaAgregarProductosState();
}

class _PaginaAgregarProductosState extends State<PaginaAgregarProductos> {
  final keyForm = GlobalKey<FormState>();
  final llamarFireBase = FirebaseDB();

  ModeloProductos producto = ModeloProductos();

  @override
  Widget build(BuildContext context) {
    final ModeloProductos prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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
      onPressed: _enviarDatos,
    );
  }

  void _enviarDatos() {
    if (!keyForm.currentState.validate()) return null;

    keyForm.currentState.save();

    if (producto.id == null) {
      llamarFireBase.crearNuevoProducto(producto);
    } else {
      llamarFireBase.modificarProducto(producto);
    }
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
}
