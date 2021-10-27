import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerfiVisitante extends StatefulWidget {
  const PerfiVisitante({Key? key}) : super(key: key);

  @override
  _PerfiVisitanteState createState() => _PerfiVisitanteState();
}

class _PerfiVisitanteState extends State<PerfiVisitante> {
  void backgrand() async {
    var resultado = await FirebaseFirestore.instance
        .collection('Dados dos Usuarios')
        .where('gmail', isEqualTo: visitantegmail)
        .get();
    setState(() {
      print(resultado.docs[0]['id']);
    });
  }

  @override
  void initState() {
    super.initState();
    backgrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF081720),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: changeUser,
          builder: (_, a, b) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: heithPorcent(25, context),
                      width: widthPorcent(100, context),
                      margin: EdgeInsets.only(bottom: heithPorcent(5, context)),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('imagems/back.gif'),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      bottom: 0,
                      left: widthPorcent(3, context),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: heithPorcent(5, context),
                        child: visitanteAvatar == ''
                            ? CircleAvatar(
                                radius: heithPorcent(4.7, context),
                                backgroundImage:
                                    AssetImage('imagems/avatar.png'),
                              )
                            : CircleAvatar(
                                radius: heithPorcent(4.85, context),
                                backgroundImage: NetworkImage(visitanteAvatar),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: heithPorcent(1.5, context),
                      left: widthPorcent(28, context),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(
                                text: "$visitanteNome\n",
                                style: TextStyle(
                                  fontSize: widthPorcent(6, context),
                                )),
                            TextSpan(
                                text: "$visitantegmail",
                                style: TextStyle(
                                    fontSize: widthPorcent(4, context),
                                    color: Color(0xffAEAEAE))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthPorcent(2, context),
                      vertical: widthPorcent(1, context)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              H2(
                                text: 'Story',
                                size: widthPorcent(4, context),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF4AA4D4),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: widthPorcent(2, context)),
                                    constraints: BoxConstraints(
                                        minHeight: heithPorcent(13, context)),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF081720),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(1),
                                    width: widthPorcent(50, context),
                                    child: H2(
                                        size: heithPorcent(2, context),
                                        text: visitantStory.length > 100
                                            ? '${visitantStory.substring(0, 100)}...'
                                            : visitantStory),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: widthPorcent(45, context),
                            child: Column(
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: '20 ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              heithPorcent(2.2, context))),
                                  TextSpan(
                                      text: 'Seguindores',
                                      style: TextStyle(color: h2color))
                                ])),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: '21 ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: widthPorcent(5, context))),
                                  TextSpan(
                                      text: 'Seguindo',
                                      style: TextStyle(color: h2color))
                                ])),
                                //editperfil[\/]
                                Custonbutton(
                                    texto: Text(
                                      'Seguidores',
                                      style: TextStyle(
                                          color: h2color, fontSize: 20),
                                    ),
                                    click: () {
                                      backgrand();
                                    }),
                                //editperfil[/\]
                                //sair[\/]
                                Custonbutton(
                                    width: widthPorcent(6.0, context),
                                    texto: H2(
                                      text: 'Seguir',
                                      size: widthPorcent(5, context),
                                    ),
                                    click: () => null),
                                //sair[/\]
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GaleriaGrid(
                  buttonText: 'Galeria',
                  context: context,
                  stream: getVisitantePosts(),
                  documentSnapshot: myposts,
                ),
                GaleriaGrid(
                  buttonText: 'Favoritos',
                  context: context,
                  stream: getVisitantefavoritos(),
                  documentSnapshot: myfavoritos,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
