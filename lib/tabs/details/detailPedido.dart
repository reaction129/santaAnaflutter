import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/main.dart';
import 'package:santaana/tabs/pedidosTab.dart';

import 'editPedido.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url = "http://nuestropandecadadia.com/deletePedido.php";
    http.post(url, body: {
      'idPedido' : widget.list[widget.index]['idPedido']
    });
  }

  void Confirmar(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Confirmar eliminacion '${widget.list[widget.index]['idPedido']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("Eliminar", style: new TextStyle(color:  Colors.black),),
          color: Colors.red,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new pedidos(),
              )
            );
          },
        ),
        new RaisedButton(
          child: new Text("Cancelar", style: new TextStyle(color: Colors.black),),
          color: Colors.green,
          onPressed: ()=> Navigator.pop(context),
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("${widget.list[widget.index]['nombreUsuario']}"),),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['comentario'], style: new TextStyle(fontSize: 20.0),),
                new Text("Cantidad de kilos : ${widget.list[widget.index]['kilos']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    new RaisedButton(
                      child: new Text("Eliminar"),
                      color: Colors.orange,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                      ),
                      onPressed: () {
                        deleteData();
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) => new santaAna()
                        ));

                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
