import 'package:eje5_login_firebase/src/blocs/login_Inheritedwidget.dart';
import 'package:eje5_login_firebase/src/pages/agregar_producto_page.dart';
import 'package:eje5_login_firebase/src/pages/homepage.dart';
import 'package:eje5_login_firebase/src/pages/loginpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'productos':(context)=>PaginaAgregarProductos(),
        },
      ),
    );
  }
}
