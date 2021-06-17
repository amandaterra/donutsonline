import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donutsonline/models/sabor.dart';

class SaborRepository {
  CollectionReference collection = Firestore.instance.collection("sabores");

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addSabor(Sabores sabor) {
    return collection.add(sabor.toJson());
  }

  updateSabor(Sabores sabor) async {
    await collection
        .document(sabor.reference.documentID)
        .updateData(sabor.toJson());
  }

  deleteSabor(Sabores sabor) async {
    await collection.document(sabor.reference.documentID).delete();
  }
}
