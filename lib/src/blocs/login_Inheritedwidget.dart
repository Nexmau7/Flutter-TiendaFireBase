export 'package:eje5_login_firebase/src/blocs/login_bloc.dart';
import 'package:eje5_login_firebase/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';

//InheritedWidget Personalizado!
class MyInheritedWidget extends InheritedWidget{

  //PATRON SINGLETON

  static MyInheritedWidget _instancia;

  factory MyInheritedWidget({Key key, Widget child}){
    if(_instancia == null){
      return _instancia = MyInheritedWidget._internal(key: key, child: child);
    }
    return _instancia;
  }

  MyInheritedWidget._internal({Key key, Widget child})
    : super(key: key, child: child);


  //Instancia UNICA para el patron Bloc con Stream(en este caso usando BehaviorSubject de rxdart)
  final loginBloc = LoginBloc();


  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=> true;

  static LoginBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>().loginBloc;
  }

}