import 'dart:convert';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:santaana/pages/clientePage.dart';

class enviarValoracion extends StatefulWidget {


  var idUsuario;
  var nombreUsuario;
  enviarValoracion({this.idUsuario, this.nombreUsuario});


  @override
  _enviarValoracionState createState() => _enviarValoracionState();
}

class _enviarValoracionState extends State<enviarValoracion> {


  TextEditingController nivel = new TextEditingController();
  TextEditingController comentario = new TextEditingController();

  var _formkey = GlobalKey<FormState>();



  Future addnewValoracion() async {
    var response;
    Dio dio = new Dio();
    var url = "http://nuestropandecadadia.com/addValoracion.php";
    FormData formData = new FormData.from({
      "nivel": nivel.text,
      "comentario": comentario.text,
      "idUsuario": widget.idUsuario,
      "nombreUsuario": widget.nombreUsuario
    });

    try{
      response = await dio.post(url, data: formData);

    } catch (e){
      print(e.toString());
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: new Text("Ayudenos a mejorar con su opinion !!"),
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
                      controller: nivel,
                      validator: (value){
                        if(value.isEmpty){
                          return "Ingrese nivel de atencion";
                        }
                      },
                      decoration: new InputDecoration(
                        hintText: "Bajo, Normal, Alto", labelText: "Nivel",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.comment , color: Colors.black,),
                    title: new TextFormField(
                      controller: comentario,
                      validator: (value){
                        if(value.isEmpty){
                          return "Ingrese comentario";
                        }
                      },
                      decoration: new InputDecoration(
                        hintText: "¿Como podemos mejorar?", labelText: "Comentario",
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
                    child: new Text("Enviar MI OPINION"),
                    color: Colors.orange,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                    onPressed: (){
                      setState(() {
                        if(_formkey.currentState.validate()){
                          addnewValoracion();
                          nivel.clear();
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
