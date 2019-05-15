import 'package:flutter/material.dart';
import 'package:santaana/login.dart';
import 'package:http/http.dart' as http;

class Client extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Bienvenido'),),
      body: new Column(
        children: <Widget>[
          new Text('aqui nos vamos a otra vista del cliente')
        ],
      ),

    );
  }
}
