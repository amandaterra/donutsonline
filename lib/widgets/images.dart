import 'package:flutter/material.dart';

Widget imagem({double pixelBottom = 100, double pixelTop = 100}) {
  return Padding(
    padding: EdgeInsets.only(top: pixelTop, bottom: pixelBottom),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red[300],
          width: 4,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.asset(
          "assets/donutt.jpg",
          fit: BoxFit.cover,
          height: 180,
          width: 180,
        ),
      ),
    ),
  );
}
