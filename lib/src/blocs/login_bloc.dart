import 'dart:async';

import 'package:eje5_login_firebase/src/blocs/validador.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Validador {
  //nota: Se cambio los StreamController por BehaviorSubject de la libreria rxdart
  //      para poder combinar streams y validar el correo con la contraseña.
  final _correoCtrl = BehaviorSubject<String>();
  final _contrasenaCtrl = BehaviorSubject<String>();

  //Insertar Valores (SINK)
  Function(String) get sinkCorreo => _correoCtrl.sink.add;
  Function(String) get sinkContra => _contrasenaCtrl.sink.add;

  //Escuchar o enviar los valores (STREAM)
  Stream<String> get streamCorreo => _correoCtrl.stream.transform(validaCorreo);
  Stream<String> get stremContra => _contrasenaCtrl.stream.transform(validaContra);

  //Get par solicitar datos finales.
  //Nota: El BehaviorSubject tiene la opcion de pedir el valor, no el Stream propio de dart.
  get correo => _correoCtrl.value;
  get contrasena => _contrasenaCtrl.value;

  //Cierra Stream
  cerrarPatronBloc() {
    _contrasenaCtrl?.close();
    _correoCtrl?.close();
  }

  //Valida la Accion del Boton! convinando los stream con la libreria de rxdart!!!!
  
  Stream<bool> get validaCorreoContrasena => Rx.combineLatest2(streamCorreo, stremContra, (a, b) => true);


}
