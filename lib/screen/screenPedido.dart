import 'package:donutsonline/models/pedido.dart';
import 'package:donutsonline/repository/databasePedido.dart';
import 'package:donutsonline/screen/screenInicio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPedido extends StatefulWidget {
  Pedido pedido;

  ScreenPedido(this.pedido);

  @override
  _ScreenPedidoState createState() => _ScreenPedidoState();
}

class _ScreenPedidoState extends State<ScreenPedido> {
  PedidoRepository repositoryPedido = PedidoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text(
          "Pedido",
          style: GoogleFonts.aladin(fontSize: 45),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          _rowSaborQuant(),
          SizedBox(height: 10),
          Expanded(child: _rowListaPedido(widget.pedido)),
          SizedBox(height: 16),
          _botaoFinalizarPedido(),
          SizedBox(height: 16),
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
          Text("Sabor", style: GoogleFonts.alice(fontSize: 25)),
          Expanded(child: Container()),
          Text("Quant.", style: GoogleFonts.alice(fontSize: 25)),
        ],
      ),
    );
  }

  Widget _rowListaPedido(Pedido pedido) {
    return ListView(
      children: pedido.lista.entries.map((e) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 35),
            Text(
              "${e.key}",
              style: GoogleFonts.alice(color: Colors.red[900], fontSize: 20),
            ),
            Expanded(child: Container()),
            Text(
              "${e.value}",
              style: GoogleFonts.alice(color: Colors.red[900], fontSize: 20),
            ),
            SizedBox(width: 75),
          ],
        );
      }).toList(),
    );
  }

  Widget _botaoFinalizarPedido() {
    return ElevatedButton(
      child: Text("Finalizar pedido", style: GoogleFonts.alice(fontSize: 18)),
      onPressed: () async {
        widget.pedido.status = "Aguardando";
        await repositoryPedido.addPedido(widget.pedido);
        Navigator.replace(context,
            oldRoute: ModalRoute.of(context),
            newRoute: MaterialPageRoute(builder: (context) => ScreenInicio()));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.red[700],
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
