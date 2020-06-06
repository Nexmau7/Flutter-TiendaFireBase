import 'package:eje5_login_firebase/src/blocs/login_Inheritedwidget.dart';
import 'package:eje5_login_firebase/src/servicios/firebase_conexion.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final soliFireBase = FirebaseDB();

  @override
  Widget build(BuildContext context) {
    final bloc = MyInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _listadeProductos(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'productos');
        },
      ),
    );
  }

  _listadeProductos() {
    return FutureBuilder(
      future: soliFireBase.recibirProductos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ModeloProductos>> snapshot) {
        final producto = snapshot.data;

        if (snapshot.hasData) {
          return _listaProd(producto);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _listaProd(List<ModeloProductos> producto) {
    return ListView.builder(
      itemCount: producto.length,
      itemBuilder: (BuildContext context, int i) {
        //final items = List<String>.generate(producto.length, (i) => "Item ${UniqueKey().toString() }");

        return Dismissible(
          //  key: Key(items[i]),
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direccion) {
            // setState(() {
            //   items.removeAt(i);
            // });
            soliFireBase.eliminarProductosDB(producto[i].id);
          },
          child: Card(
            child: Column(
              children: <Widget>[
                (producto[i].fotoUrl == null)
                    ? Image.asset('assets/images/no-image.png')
                    : FadeInImage(
                        placeholder:
                            AssetImage('assets/images/jar-loading.gif'),
                        image: NetworkImage(producto[i].fotoUrl)),
                ListTile(
                  title: Text(
                      '${producto[i].titulo}  Precio: \$${producto[i].valor}'),
                  subtitle: Text(producto[i].id),
                  onTap: () {
                    Navigator.pushNamed(context, 'productos',
                        arguments: producto[i]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
