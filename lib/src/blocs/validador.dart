import 'dart:async';

class Validador{

  final validaContra = StreamTransformer<String,String>.fromHandlers(
    handleData: (contra, sink) {
      if(contra.length >= 6  ){
        sink.add(contra);
      }else{
        sink.addError('Mas de 6 Caracteres');
      }
    },
  );

  final validaCorreo = StreamTransformer<String,String>.fromHandlers(
    handleData: (correo, sink) {

      Pattern patron = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp exprecionRegular = RegExp(patron);

      if( exprecionRegular.hasMatch(correo) ){
          sink.add(correo);
      }else{
        sink.addError('Correo Incorrecto');
      }
      
    },
  );


}