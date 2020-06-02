import 'package:eje5_login_firebase/src/blocs/login_Inheritedwidget.dart';
import 'package:flutter/material.dart';

class FormularioIngreso extends StatelessWidget {
  const FormularioIngreso({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.31,
            width: double.infinity,
          ),
          Container(
            width: size.width * 0.88,
            padding: EdgeInsets.symmetric(vertical: 40.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: CajaFormulario(),
          ),
          Text('¿Olvido la contraseña?')
        ],
      ),
    );
  }
}

class CajaFormulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = MyInheritedWidget.of(context);

    return Column(
      children: <Widget>[
        Text(
          'Ingreso',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        _cajaCorreo(bloc),
        _cajaContrasena(bloc),
        _botonValidaIngreso(bloc),
      ],
    );
  }

  Widget _cajaCorreo(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.streamCorreo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo Electronico',
              hintText: 'ejemplo@mail.com',
              errorText: snapshot.error,
              filled: true,
              labelStyle: TextStyle(color: Colors.deepPurple),
              fillColor: Colors.deepPurple[100],
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
            ),
            onChanged: bloc.sinkCorreo,
          ),
        );
      },
    );
  }

  Widget _cajaContrasena(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.stremContra,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: '*****',
              errorText: snapshot.error,
              filled: true,
              labelStyle: TextStyle(color: Colors.deepPurple),
              fillColor: Colors.deepPurple[100],
              icon: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
            ),
            onChanged: (value) => bloc.sinkContra(value),
          ),
        );
      },
    );
  }

  Widget _botonValidaIngreso(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.validaCorreoContrasena,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          color: Colors.deepPurple,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
            child: Text(
              'Ingresar',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          onPressed: snapshot.hasData
              ? () {
                  _accederHome(context);
                }
              : null,
        );
      },
    );
  }

  void _accederHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
