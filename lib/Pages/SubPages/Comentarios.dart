import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comentarios extends StatelessWidget {
  const Comentarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heithPorcent(100, context),
      width: widthPorcent(100, context),
      color: Color(0xFF041015),
    );
  }
}

TextEditingController _comentarioText = TextEditingController();
void _savaComentarios() {
  if (_comentarioText.text != '') {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(Idcomentario)
        .collection('comentarios')
        .doc(criateID())
        .set({
      'user': userKey,
      'data': data,
      'hora': hora,
      'comentarios': _comentarioText.text,
    }).whenComplete(() => _comentarioText.text = '');
  }
}
