import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donutsonline/models/pedido.dart';

class PedidoRepository {
  CollectionReference collection = Firestore.instance.collection("pedidos");

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPedido(Pedido pedido) {
    return collection.add(pedido.toJson());
  }

  updatePedido(Pedido pedido) async {
    await collection
        .document(pedido.reference.documentID)
        .updateData(pedido.toJson());
  }

  deletePedido(Pedido pedido) async {
    await collection.document(pedido.reference.documentID).delete();
  }
}
