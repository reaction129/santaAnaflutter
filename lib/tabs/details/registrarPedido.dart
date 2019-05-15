import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/pedidosTab.dart';

class RegistrarPedido extends StatefulWidget {
  @override
  _RegistrarPedidoState createState() => _RegistrarPedidoState();
}

class _RegistrarPedidoState extends State<RegistrarPedido> {
  TextEditingController kilos = new TextEditingController();
  TextEditingController comentario = new TextEditingController();

  //aqui hay q capturar el nombre o la id del cliente logeado();

  var _formkey = GlobalKey<FormState>();

  void addnewPedido(){
    var url = "http://localhost:8889/santaAnaflutter/addpedido.php";

    http.post(url, body: {
      "kilos": kilos.text,
      "comentario": comentario.text,
      //la id o algo del cliente logeado();
      "idCliente": pedidos
  });
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
                      validator: (value){
                        if(value.isEmpty) return "Ingrese kilos";
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
                      validator: (value){
                        if(value.isEmpty) return "Ingrese comentario";
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
                    child: new Text("Guardar Cambios"),
                    color: Colors.black,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/pedidosTab');
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
