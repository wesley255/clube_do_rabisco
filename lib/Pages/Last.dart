// ignore_for_file: implementation_imports

import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Last extends StatefulWidget {
  const Last({Key? key}) : super(key: key);

  @override
  _LastState createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 50)),
            Text(''),
            Custonbutton(texto: H2(text: 'test'), click: () {})
          ],
        ),
      ),
    );
  }
}
