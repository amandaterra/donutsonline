import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donutsonline/models/sabor.dart';
import 'package:donutsonline/models/pedido.dart';
import 'package:donutsonline/repository/databaseSabor.dart';
import 'package:donutsonline/screen/screenCozinha.dart';
import 'package:donutsonline/screen/screenPedido.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenAtendimento extends StatefulWidget {
  @override
  _ScreenAtendimentoState createState() => _ScreenAtendimentoState();
}

class _ScreenAtendimentoState extends State<ScreenAtendimento> {
  SaborRepository repositorySabor = SaborRepository();
  Pedido pedido = Pedido(lista: new Map<String, int>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Atendimento", style: GoogleFonts.aladin(fontSize: 45)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment(-0.8, 0.0),
            child: Text("Selecione o sabor do pedido: ",
                style: GoogleFonts.aladin(fontSize: 25)),
          ),
          SizedBox(height: 10),
          Expanded(child: _carregarSabores()),
          _row(),
          Container(),
        ],
      ),
    );
  }

  Widget _carregarSabores() {
    Widget _sabor(DocumentSnapshot snapshot) {
      final sabor = Sabores.fromSnapshot(snapshot);

      if (sabor == null) return Container();

      return Card(
        margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 2.5,
            color: Colors.redAccent[700],
          ),
        ),
        child: Container(
          child: ListTile(
            title: Text(sabor.nome,
                style: GoogleFonts.alice(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center),
            onTap: () {
              TextEditingController _quantController = TextEditingController();

              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Adicionar '${sabor.nome}'",
                    style: GoogleFonts.alice(),
                  ),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          "Quantidade a ser adicionada:",
                          style: GoogleFonts.alice(),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _quantController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.alice(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                    ),
                    ElevatedButton(
                      child: Text(
                        "Confirmar",
                        style: GoogleFonts.alice(),
                      ),
                      onPressed: () {
                        if (pedido.lista[sabor.nome] == null)
                          pedido.lista[sabor.nome] = 0;
                        pedido.lista[sabor.nome] +=
                            int.parse(_quantController.text);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  ],
                  actionsPadding: EdgeInsets.symmetric(horizontal: 5),
                ),
              );
            },
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: repositorySabor.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return ListView(
          children: snapshot.data.documents.map((e) => _sabor(e)).toList(),
        );
      },
    );
  }

  Widget _row() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text(
              "Finalizar pedido",
              style: GoogleFonts.alice(),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenPedido(pedido)));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[900],
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          ElevatedButton(
            child: Text(
              "Cozinha",
              style: GoogleFonts.alice(),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenCozinha()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[900],
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
