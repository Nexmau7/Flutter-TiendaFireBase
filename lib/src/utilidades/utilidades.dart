
//Funcion que determina si es un numero o no
bool esNumero(String palabra){
  
  if(palabra.isEmpty) return false;

  //num.tryParse intentara pasar el String a numero si no puede devolvera NULL
  final resp = num.tryParse(palabra);

  return (resp == null) ? false : true;
}