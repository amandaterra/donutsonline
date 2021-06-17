import 'package:cloud_firestore/cloud_firestore.dart';

class Sabores {
  String nome;
  DocumentReference reference;

  Sabores({this.nome, this.reference});

  Sabores.fromMap(Map<String, dynamic> map, {this.reference})
      : nome = map['nome'];

  Sabores.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => _SaboresToJson(this);
}

Map<String, dynamic> _SaboresToJson(Sabores instance) => <String, dynamic>{
      'nome': instance.nome,
    };
