import 'package:eje5_login_firebase/src/widgets/cabeza_login.dart';
import 'package:eje5_login_firebase/src/widgets/formulario_ingreso.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CabezaLogin(),
          FormularioIngreso(),
        ],
      ),
    );
  }
}