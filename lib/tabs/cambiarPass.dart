import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:santaana/main.dart';
import 'package:santaana/pages/clientePage.dart';

class CambiarPass extends StatefulWidget {
  final String idUsuario;
  final String pass;
  final String perfil;
  CambiarPass({this.idUsuario, this.pass, this.perfil});

  @override
  _CambiarPassState createState() => _CambiarPassState();
}

class _CambiarPassState extends State<CambiarPass> {
  TextEditingController newPass = new TextEditingController();
  var _formkey = GlobalKey<FormState>();

  Response response;
  Dio dio = new Dio();
  var url = "http://nuestropandecadadia.com/cambiarPass.php";

  cambiarPass() async {
    FormData formData = new FormData.from(
        {"newPass": newPass.text, "idUsuario": widget.idUsuario});

    try {
      response = await dio.post(url,
          data: formData, options: Options(responseType: ResponseType.plain));
    } catch (e) {
      print(e.toString());
      print(response.data);
    }
  }

  @override
  Widget build(BuildContext context) {

    print(widget.idUsuario);
    print(widget.perfil);
    return Scaffold(
      appBar: AppBar(
        title: new Text("Cambiar contraseña"),
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
                    leading: const Icon(
                      Icons.vpn_key,
                      color: Colors.black,
                    ),
                    title: new TextFormField(
                      controller: newPass,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 8){
                          return "Contraseña muy debil";
                        }

                      },
                      decoration: new InputDecoration(
                        hintText: "Nueva contraseña",
                        labelText: "Nueva contraseña",
                      ),
                    ),
                  ),
                  new RaisedButton(
                    child: new Text("CAMBIAR"),
                    color: Colors.orange,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      cambiarPass();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new santaAna()));
                    },
                  ),
                  new RaisedButton(
                    child: new Text("VOLVER AL INICIO"),
                    color: Colors.orange,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ClientPage()));
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
