import 'package:flutter/material.dart';
import 'package:santaana/login.dart';
import 'package:http/http.dart' as http;
import 'package:santaana/login.dart';
import 'package:santaana/tabs/details/registrarPedido.dart';
import 'package:santaana/tabs/enviarValoracion.dart';
import 'package:santaana/tabs/cambiarPass.dart';

class ClientPage extends StatefulWidget {
  var idUsuario;
  var nombreUsuario;
  var perfil;
  ClientPage({Key key, this.idUsuario, this.nombreUsuario, this.perfil});

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    final TabController = new DefaultTabController(
      length: 2,
      child: new Scaffold(
        drawer: Drawer(

          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("BIENVENIDO"),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.orange : Colors.brown,
                  child: Text(":)",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: Text("Cambiar mi contraseña"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => new CambiarPass(idUsuario: ID, perfil: perfilUser)
                  ));
                },
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text('Panaderia Santa Ana'),
          bottom: new TabBar(
            indicatorColor: Colors.black12,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.whatshot),
                text: "Valora nuestro servicio",
              ),
              new Tab(

                icon: new Icon(Icons.warning),
                text: "Realizar Pedido",
              ),
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new enviarValoracion(
                idUsuario: widget.idUsuario,
                nombreUsuario: widget.nombreUsuario),
            new RegistrarPedido(idUsuario: widget.idUsuario, nombreUsuario: widget.nombreUsuario,)
          ],
        ),
      ),
    );

    return new MaterialApp(
      title: ('Panaderia Santa ANA'),
      theme: new ThemeData(primarySwatch: Colors.brown),
      home: TabController,
    );
  }
}
