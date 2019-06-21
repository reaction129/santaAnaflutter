import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/main.dart';

class DetailValoracion extends StatefulWidget {
  List list;
  int index;
  DetailValoracion({this.index, this.list});

  @override
  _DetailValoracionState createState() => _DetailValoracionState();
}

class _DetailValoracionState extends State<DetailValoracion> {
  void deleteValoracion() {
    var url = "http://nuestropandecadadia.com/deleteValoracion.php";
    http.post(url,
        body: {'idValoracion': widget.list[widget.index]['idValoracion']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("${widget.list[widget.index]['nombreUsuario']}"),
      ),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['nivel'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Opinion del servicio: ${widget.list[widget.index]['comentario']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Eliminar"),
                      color: Colors.orange,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        deleteValoracion();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new santaAna()));
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
