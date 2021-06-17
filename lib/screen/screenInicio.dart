import 'package:donutsonline/screen/screenAtendimento.dart';
import 'package:donutsonline/screen/screenCozinha.dart';
import 'package:donutsonline/widgets/elevatedButton.dart';
import 'package:donutsonline/widgets/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          "DonutsOnline",
          style: GoogleFonts.aladin(fontSize: 45),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagem(),
            botao(context, "Atendimento", ScreenAtendimento(), Icons.paste),
            SizedBox(
              height: 20,
            ),
            botao(
              context,
              "Cozinha",
              ScreenCozinha(),
              Icons.restaurant_menu_outlined,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
