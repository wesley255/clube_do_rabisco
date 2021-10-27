import 'package:chat2/Pages/SubPages/criate_Desafio.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Desfilos extends StatefulWidget {
  const Desfilos({Key? key}) : super(key: key);

  @override
  _DesfilosState createState() => _DesfilosState();
}

class _DesfilosState extends State<Desfilos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041015),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: getDesafios(),
                builder: (_, desafil) {
                  switch (desafil.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      listDesafils = desafil.data!.docs;
                      return Container();
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDesafil())),
        backgroundColor: Color(0xff4AA4D4),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
