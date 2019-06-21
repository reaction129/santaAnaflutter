import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:santaana/pages/clientePage.dart';

class RegistrarPedido extends StatefulWidget {

  var idUsuario;
  var nombreUsuario;
  RegistrarPedido({this.idUsuario, this.nombreUsuario});

  @override
  _RegistrarPedidoState createState() => _RegistrarPedidoState();
}

class _RegistrarPedidoState extends State<RegistrarPedido> {


  TextEditingController kilos = new TextEditingController();
  TextEditingController comentario = new TextEditingController();


  var _formkey = GlobalKey<FormState>();

  Future addnewPedido() async{

    var response;
    Dio dio = new Dio();
    var url = "http://nuestropandecadadia.com/addpedido.php";
    FormData formData = new FormData.from({
      "kilos": kilos.text,
      "comentario": comentario.text,
      "idUsuario": widget.idUsuario,
      "nombreUsuario": widget.nombreUsuario
    });

    try{
      response = await dio.post(url, data: formData);
    } catch (e){
      print('a');
      print(e.toString());
    }


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: new Text("Crear Nuevo Pedido"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.assignment_late , color: Colors.black,),
                    title: new TextFormField(
                      controller: kilos,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Ingrese kilos";
                        }
                      },
                      decoration: new InputDecoration(
                        hintText: "Kilos", labelText: "Kilos",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.comment , color: Colors.black,),
                    title: new TextFormField(
                      controller: comentario,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Ingrese comentario";
                        }
                      },
                      decoration: new InputDecoration(
                        hintText: "Comentario", labelText: "Comentario",
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Solicitar Pan"),
                    color: Colors.orange,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    onPressed: (){
                      setState(() {
                        if(_formkey.currentState.validate()){
                          addnewPedido();
                          kilos.clear();
                          comentario.clear();
                        }
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
