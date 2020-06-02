import 'package:eje5_login_firebase/src/blocs/login_Inheritedwidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = MyInheritedWidget.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Correo: ${bloc.correo}'),
          SizedBox(height: 10.0,width: double.infinity,),
          Text('Contraseña: ${bloc.contrasena} '),
        ],
      ),
    );
  }
}