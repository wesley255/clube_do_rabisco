// ignore_for_file: implementation_imports, unused_import

import 'package:chat2/Pages/SubPages/Editar_perfil.dart';
import 'package:chat2/Pages/Pageview.dart';
import 'package:chat2/services/auth_service.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/src/provider.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
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
                        child: globalAvatar == ''
                            ? CircleAvatar(
                                radius: heithPorcent(4.7, context),
                                backgroundImage:
                                    AssetImage('imagems/avatar.png'),
                              )
                            : CircleAvatar(
                                radius: heithPorcent(4.85, context),
                                backgroundImage: NetworkImage(globalAvatar),
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
                                text: "$globalName\n",
                                style: TextStyle(
                                  fontSize: widthPorcent(6, context),
                                )),
                            TextSpan(
                                text: "$globalGmail",
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
                                        text: story.length > 100
                                            ? '${story.substring(0, 100)}...'
                                            : story),
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
                                    'Editar Perfil',
                                    style:
                                        TextStyle(color: h2color, fontSize: 20),
                                  ),
                                  click: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditarPerfil()));
                                  },
                                ),
                                //editperfil[/\]
                                //sair[\/]
                                Custonbutton(
                                  width: widthPorcent(8.7, context),
                                  color: Colors.redAccent,
                                  texto: H2(
                                    text: 'Sair',
                                    size: widthPorcent(5, context),
                                  ),
                                  click: () =>
                                      context.read<AuthServise>().logout(),
                                ),
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
                  stream: getMyPosts(),
                  documentSnapshot: myposts,
                ),
                GaleriaGrid(
                  buttonText: 'Favoritos',
                  context: context,
                  stream: getMyfavoritos(),
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

var isOpenGaleria = ValueNotifier(false);
var isOpenFavorito = ValueNotifier(false);
