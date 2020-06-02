import 'package:flutter/material.dart';

class CabezaLogin extends StatelessWidget {
  const CabezaLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple[800],
            Colors.purple[800],
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          _circulosTransparentes(),
          _logoEmpresa(),
        ],
      ),
    );
  }

  Widget _circulosTransparentes() {
    final _circulo = Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(100.0),
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned(
          top: 80,
          left: 30,
          child: _circulo,
        ),
        Positioned(
          top: -25,
          right: -30,
          child: _circulo,
        ),
        Positioned(
          bottom: -30,
          right: 10,
          child: _circulo,
        ),
      ],
    );
  }

  Widget _logoEmpresa() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          child: Icon(
            Icons.whatshot,
            size: 120,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10, width: double.infinity),
        Text(
          'Premium',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}