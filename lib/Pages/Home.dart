// ignore_for_file: unnecessary_statements, unused_local_variable
import 'dart:io';
import 'package:chat2/Pages/Pageview.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041015),
      body: SafeArea(
          child: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            margin: EdgeInsetsDirectional.only(top: 10),
            width: widthPorcent(95, context),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        page.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: ValueListenableBuilder(
                          valueListenable: changeUser,
                          builder: (_, a, b) {
                            return globalAvatar == ''
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(globalAvatar),
                                    radius: heithPorcent(2.7, context),
                                  );
                          }),
                    ),
                    CaixaDeTexto(
                      controller: _labelPost,
                      iconClick: () async {
                        _imageHome = await getImage();
                        if (_imageHome != null) {
                          cardHomeVisivel = true;
                        }
                        cardHome.value = !cardHome.value;
                      },
                      borderLaft: 15,
                      borderRiad: 15,
                      borderTopRiad: 15,
                      heith: 15,
                      label: 'postar novo Desenho..',
                      width: widthPorcent(80, context),
                      muiltline: true,
                      icon: Padding(
                        padding: EdgeInsets.only(top: 3, right: 5),
                        child: Icon(
                          Icons.photo,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: cardHome,
                    builder: (_, a, b) {
                      return AnimatedContainer(
                          duration: Duration(microseconds: 200),
                          width: double.infinity,
                          child: cardHomeVisivel
                              ? Column(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: heithPorcent(30, context),
                                      ),
                                      child: Image.file(_imageHome!),
                                    ),
                                    cardHomeLoad
                                        ? Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: heithPorcent(3, context),
                                            width: heithPorcent(3, context),
                                            child: CircularProgressIndicator())
                                        : Custonbutton(
                                            texto: H2(text: 'Postar'),
                                            click: () async {
                                              cardHomeLoad = true;
                                              cardHome.value = !cardHome.value;

                                              await upadatePost(
                                                  _labelPost.text, _imageHome);
                                              cardHomeVisivel = false;
                                              cardHomeLoad = false;
                                              _imageHome = null;
                                              _labelPost.text = '';
                                              cardHome.value = !cardHome.value;
                                            })
                                  ],
                                )
                              : SizedBox());
                    }),
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: getPosts(),
                      builder: (_, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            posts = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    children: [
                                      CardPostHome(
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
                                        avatar: snapshot.data!.docs[index]
                                            ['avatar'],
                                        data: snapshot.data!.docs[index]
                                            ['data'],
                                        title: snapshot.data!.docs[index]
                                            ['nome'],
                                        subTitle: snapshot.data!.docs[index]
                                            ['gmail'],
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
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class CardPostHome extends StatelessWidget {
  final String title;
  final String subTitle;
  final String desafil;
  final String label;
  final String data;
  final String avatar;
  final String image;
  final Function? favorito;
  final Function? mensage;
  final String like;

  CardPostHome({
    required this.title,
    required this.subTitle,
    required this.desafil,
    required this.label,
    required this.data,
    required this.avatar,
    required this.image,
    this.favorito,
    this.mensage,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: heithPorcent(30, context),
      ),
      child: Column(
        children: [
          Cabesario(
            avatar: avatar,
            data: data,
            title: title,
            subTitle: subTitle,
            label: label,
            desafil: desafil,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  if (favorito != null) {
                    favorito!();
                  }
                },
                icon: like.contains(auth.currentUser!.email.toString())
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ),
              ),
              IconButton(
                  onPressed: () {
                    if (mensage != null) {
                      mensage!();
                    }
                  },
                  icon: Icon(Icons.chat_bubble_outline)),
              IconButton(onPressed: null, icon: Icon(Icons.send))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Color(0xFF18455E),
            height: 2,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class Cabesario extends StatelessWidget {
  final String title;
  final String subTitle;
  final String desafil;
  final String label;
  final String data;
  final String avatar;

  Cabesario({
    required this.title,
    required this.subTitle,
    required this.desafil,
    required this.label,
    required this.data,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: widthPorcent(6, context),
                child: avatar == ''
                    ? CircleAvatar(
                        backgroundImage: AssetImage('imagems/avatar2.png'),
                        radius: widthPorcent(5.9, context),
                      )
                    : subTitle != globalGmail
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(avatar),
                            radius: widthPorcent(5.9, context),
                          )
                        : ValueListenableBuilder(
                            valueListenable: changeUser,
                            builder: (_, a, b) {
                              return CircleAvatar(
                                  backgroundImage: NetworkImage(globalAvatar),
                                  radius: widthPorcent(5.9, context));
                            }),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title),
                        Row(
                          children: [
                            H2(text: data),
                            GestureDetector(child: Icon(Icons.more_horiz)),
                          ],
                        ),
                      ]),
                  H2(text: subTitle),
                ],
              ),
            )
          ],
        ),
        desafil != ''
            ? Text(
                '#$desafil',
                style: TextStyle(color: Color(0xff4AA4D4)),
              )
            : SizedBox(),
        label != '' ? Text(label) : SizedBox()
      ],
    );
  }
}

TextEditingController _labelPost = TextEditingController();
File? _imageHome;
bool cardHomeVisivel = false;
var cardHome = ValueNotifier<bool>(false);
bool cardHomeLoad = false;

qualityPorecent(double tatalMb, double tamanhoFinal) {
  int porcent;
  porcent = ((tatalMb / 100 * tamanhoFinal) * 100).toInt();
  if (porcent == 0) {
    return 1;
  } else {
    print(porcent);
    return porcent;
  }
}
