// ignore_for_file: implementation_imports

import 'package:chat2/Pages/SubPages/Desafios.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';

import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'Home.dart';

class Last extends StatefulWidget {
  const Last({Key? key}) : super(key: key);

  @override
  _LastState createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  void initState() {
    super.initState();
    updatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041015),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  CardDsafil(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(globalAvatar),
                            radius: 24.5,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        width: widthPorcent(82, context),
                        child: CaixaDeTexto(
                          iconClick: () {
                            updatedata();
                          },
                          muiltline: true,
                          label: '  Publicar Novo Rascunho',
                          heith: 20,
                          borderLaft: 15,
                          borderRiad: 15,
                          borderTopRiad: 15,
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10, top: 5),
                            child: Icon(
                              Icons.photo,
                              color: Colors.lightBlue,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Color(0xFF18455E),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: getPosts(),
                      builder: (_, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container(
                              constraints: BoxConstraints(
                                  minHeight: heithPorcent(100, context)),
                              child: CircularProgressIndicator(),
                            );
                          default:
                            posts = snapshot.data!.docs;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: posts.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    children: [
                                      CardPostHome(
                                        mensage: () {
                                          Idcomentario =
                                              snapshot.data!.docs[index]['id'];
                                          coment.value = true;
                                        },
                                        keypost: snapshot.data!.docs[index]
                                            ['userKey'],
                                        like: snapshot
                                            .data!.docs[index]['favoritos']
                                            .toString(),
                                        favorito: () {
                                          if (snapshot
                                              .data!.docs[index]['favoritos']
                                              .toString()
                                              .contains(globalGmail)) {
                                            desfavoritar(snapshot
                                                .data!.docs[index]['id']);
                                          } else {
                                            favorito(snapshot.data!.docs[index]
                                                ['id']);
                                          }
                                        },
                                        image: snapshot.data!.docs[index]
                                            ['image'],
                                        avatar: '',
                                        data: '',
                                        title: '',
                                        subTitle: '',
                                        desafil: 'Cenarios',
                                        label: snapshot.data!.docs[index]
                                            ['label'],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardDsafil extends StatelessWidget {
  const CardDsafil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Desfilos())),
        child: Stack(
          children: [
            //imagem de fundo\/
            Container(
              height: heithPorcent(20, context),
              width: widthPorcent(100, context),
              decoration: BoxDecoration(
                color: Color(0xFF113043),
                image: DecorationImage(
                    image: AssetImage('imagems/Back.png'), fit: BoxFit.cover),
              ),
            ),
            //barra de tempo
            Positioned(
              bottom: 0,
              child: Center(
                child: Container(
                  width: widthPorcent(100, context),
                  height: heithPorcent(5, context),
                  color: Color.fromRGBO(48, 114, 149, 0.6),
                  child: Center(child: TimeDesafil()),
                ),
              ),
            ),
            // next
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: heithPorcent(11, context)),
                child: Text(
                  'Proximo tema em:',
                  style: TextStyle(
                    fontSize: 20,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //tema
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: heithPorcent(3.5, context)),
                child: Text(
                  '"Cenarios"',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var timedesafil = ValueNotifier<String>('11d: 22h :33m :44s');

class TimeDesafil extends StatelessWidget {
  const TimeDesafil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: timedesafil,
      builder: (_, a, b) {
        return Text(
          (dataRestante),
          style: TextStyle(
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 5,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ],
          ),
        );
      },
    );
  }
}

int ta = 0;
var berlinWallFell = DateTime.parse('2021-11-01T00:00:00');
updatedata() async {
  if (DateTime.now().difference(berlinWallFell).inSeconds <= 0) {
    int dataLength =
        DateTime.now().difference(berlinWallFell).toString().length;
    int thisH = DateTime.now().difference(berlinWallFell).inHours;

    hora = ((thisH ~/ 24) * 24 - thisH).toString();
    min = DateTime.now()
        .difference(berlinWallFell)
        .toString()
        .substring(dataLength - 12, dataLength - 10);
    seg = DateTime.now()
        .difference(berlinWallFell)
        .toString()
        .substring(dataLength - 9, dataLength - 7);
    dias = (DateTime.now().difference(berlinWallFell).inDays * -1).toString();
    //
    dataRestante = '${dias}d: ${hora}h: ${min}m: ${seg}s';
    timedesafil.value = DateTime.now().toString();
    //
    await Future.delayed(Duration(seconds: 1), updatedata);
  }
}

String dataRestante = '';
String hora = '';
String min = '';
String seg = '';
String dias = '';
String datalimite = '2021102100000';
