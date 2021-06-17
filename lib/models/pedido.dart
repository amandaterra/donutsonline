import 'package:cloud_firestore/cloud_firestore.dart';

class Pedido {
  Map<String, dynamic> lista;
  String status;
  DocumentReference reference;

  Pedido({this.lista, this.status, this.reference});

  Pedido.fromMap(Map<String, dynamic> map, {this.reference})
      : lista = map['lista'],
        status = map['status'];

  Pedido.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => PedidoToJson(this);
}

Map<String, dynamic> PedidoToJson(Pedido instance) => <String, dynamic>{
      'lista': instance.lista,
      'status': instance.status,
    };
