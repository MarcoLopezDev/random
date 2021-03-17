import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}
void main() => runApp(MyApp());

//Primer widget inmutable

class MyApp extends StatelessWidget{
  const MyApp({Key key}) : super( key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget{
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  Future<String> sendData() async{ //New Function to send emails
    
    var stepsData = jsonEncode(<String, String>{
        "DateTime":DateTime.now().toIso8601String(),
        "random":_random
    });

    var response = await http.post(
      Uri.https('apidoblemarco.azurewebsites.net', '/api/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: stepsData
    );
    print(response.body);
    return "Success!!";
  }

var _random;

void generarRandom(){
  var _random = new Random();
  
  for (var i = 0; i < 10; i++) {
    print(_random.nextInt(100));
  }

  sendData();
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi App Dark"),       
      ),
      body: Center(
        child: new ElevatedButton(
          onPressed: sendData, 
          child: new Text("Generar numero random")
          ),
          
     ),
     
    );
  }
}