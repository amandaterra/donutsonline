import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donutsonline/models/pedido.dart';
import 'package:donutsonline/models/ultimoPedido.dart';
import 'package:donutsonline/repository/databasePedido.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenCozinha extends StatefulWidget {
  @override
  _ScreenCozinhaState createState() => _ScreenCozinhaState();
}

class _ScreenCozinhaState extends State<ScreenCozinha> {
  PedidoRepository repositoryPedido = PedidoRepository();
  UltimoPedido ultimoPedido = UltimoPedido();

  _save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("ultimoPedido", jsonEncode(ultimoPedido));
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var pedido = prefs.getString("ultimoPedido");

    if (pedido != null) {
      var decoded = jsonDecode(pedido);
      setState(() {
        ultimoPedido.reference = decoded['reference'];
        ultimoPedido.data = decoded['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          "Cozinha",
          style: GoogleFonts.aladin(fontSize: 50),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Text(
              "Clique e segure em um pedido para mudar seu status para 'Pronto'",
              style: GoogleFonts.alice(color: Colors.red[900], fontSize: 14)),
          SizedBox(height: 20),
          _rowSaborQuant(),
          SizedBox(height: 20),
          Expanded(child: _rowPedidos()),
          _ultimoPedidoEntregue(),
          Container(),
        ],
      ),
    );
  }

  Widget _rowSaborQuant() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pedido", style: GoogleFonts.alice(fontSize: 25)),
          Expanded(child: Container()),
          Text("Status", style: GoogleFonts.alice(fontSize: 25)),
        ],
      ),
    );
  }

  Widget _rowPedidos() {
    Widget _pedido(DocumentSnapshot snapshot) {
      final pedido = Pedido.fromSnapshot(snapshot);

      if (pedido == null || pedido.status == "Entregue") return Container();

      return Container(
        height: 65,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          child: Card(
            elevation: 2,
            child: Row(
              children: [
                SizedBox(width: 10),
                Container(
                  width: 200,
                  child: Text("Pedido ${pedido.reference.documentID}",
                      style: GoogleFonts.alice(fontSize: 16)),
                ),
                Expanded(child: Container()),
                Text("${pedido.status}",
                    style: GoogleFonts.alice(fontSize: 16)),
                Expanded(child: Container()),
              ],
            ),
          ),
          //DETALHES DO PEDIDO
          onTap: () {
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "Detalhes 'pedido ${pedido.reference.documentID}'",
                  style: GoogleFonts.alice(),
                ),
                content: Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: pedido.lista.entries.map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${e.key}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "${e.value}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      Container(),
                    ],
                  ),
                ),
                actions: [
                  if (pedido.status == "Pronto")
                    ElevatedButton(
                      child: Text(
                        "Entregar o pedido",
                        style: GoogleFonts.alice(),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                      onPressed: () {
                        pedido.status = "Entregue";
                        repositoryPedido.updatePedido(pedido);
                        setState(() {
                          ultimoPedido.reference = pedido.reference.documentID;
                          DateTime atual = new DateTime.now();
                          String data = atual.day.toString() +
                              "/" +
                              atual.month.toString() +
                              "/" +
                              atual.year.toString() +
                              " " +
                              atual.hour.toString() +
                              ":" +
                              atual.minute.toString();
                          ultimoPedido.data = data;
                          _save();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  if (pedido.status == "Aguardando")
                    ElevatedButton(
                      child: Text("O pedido ainda não está pronto"),
                    ),
                ],
              ),
            );
          },
          onLongPress: () {
            pedido.status = "Pronto";
            repositoryPedido.updatePedido(pedido);
          },
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: repositoryPedido.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return ListView(
          children: snapshot.data.documents.map((e) => _pedido(e)).toList(),
        );
      },
    );
  }

  Widget _ultimoPedidoEntregue() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          width: 3.5,
          color: Colors.redAccent[700],
        ),
      ),
      child: ListTile(
        title: Text(
          "ÚLTIMO PEDIDO ENTREGUE",
          style: GoogleFonts.alice(),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Pedido ${ultimoPedido.reference}",
              style: GoogleFonts.alice(
                color: Colors.red[900],
              ),
            ),
            Text(
              "${ultimoPedido.data}",
              style: GoogleFonts.alice(
                color: Colors.red[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
