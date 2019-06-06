import 'package:flutter/material.dart';
import 'package:santaana/login.dart';
import 'package:http/http.dart' as http;

class ClientPage extends StatefulWidget {
  ClientPage({this.rut, this.idCliente});
  final String rut;
  final String idCliente;



  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

