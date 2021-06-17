import 'package:cloud_firestore/cloud_firestore.dart';

class UltimoPedido {
  String reference;
  String data;

  UltimoPedido({this.reference, this.data});

  UltimoPedido.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ultimoPedido = new Map<String, dynamic>();
    ultimoPedido['reference'] = this.reference;
    ultimoPedido['data'] = this.data;
    return ultimoPedido;
  }
}
