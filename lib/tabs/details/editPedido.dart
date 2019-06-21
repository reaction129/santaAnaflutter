import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/tabs/pedidosTab.dart';

class editPedido extends StatefulWidget {
  final List list;
  final int index;

  editPedido({this.list, this.index});

  @override
  _editPedidoState createState() => _editPedidoState();
}

class _editPedidoState extends State<editPedido> {

  TextEditingController kilos;
  TextEditingController comentario;


  void editPedido(){
    var url = "http://nuestropandecadadia.com/editPedido.php";
        http.post(url, body: {
          'idPedido': widget.list[widget.index]['idPedido'],
          'kilos': kilos.text,
          'comentario': comentario.text,
        });
  }
  @override
  void initState() {
    kilos = new TextEditingController(text: widget.list[widget.index]['kilos']);
    comentario = new TextEditingController(text: widget.list[widget.index]['comentario']);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Editar"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.assignment_late, color: Colors.black,),
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
                  leading: const Icon(Icons.comment, color: Colors.black,),
                  title: new TextFormField(
                    controller: comentario,
                    validator: (value){
                      if (value.isEmpty)return "Ingrese comentario";
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
                  onPressed: (){
                    editPedido();
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new pedidos()
                    ));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

