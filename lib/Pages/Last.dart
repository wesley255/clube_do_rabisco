// ignore_for_file: implementation_imports

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
        child: StreamBuilder<QuerySnapshot>(
          stream: getlistUser(),
          builder: (_, snapshotUser) {
            switch (snapshotUser.connectionState) {
              case ConnectionState.none:
                return Center(child: H2(text: 'Sem internet'));
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                listUser = snapshotUser.data!.docs;
                var u = snapshotUser.data;
                return ListView.builder(
                  itemCount: listUser.length,
                  itemBuilder: (_, i) {
                    return Container(
                        child: H2(text: u!.docChanges.toList().toString()));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
