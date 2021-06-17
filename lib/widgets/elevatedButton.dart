import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget botao(BuildContext context, String label, proximaPagina, IconData icon) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => proximaPagina),
      );
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 20)),
        SizedBox(width: 5),
        Icon(icon),
      ],
    ),
    style: ElevatedButton.styleFrom(
      minimumSize: Size(200, 45),
      primary: Colors.red[900],
      textStyle: GoogleFonts.alice(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}
