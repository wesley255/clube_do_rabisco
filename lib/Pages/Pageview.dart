// ignore_for_file: unused_local_variable

import 'package:chat2/Pages/Home.dart';
import 'package:chat2/Pages/Last.dart';
import 'package:chat2/Pages/Perfil.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:flutter/material.dart';

PageController page = PageController(initialPage: 1);

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  void initState() {
    super.initState();
    getlistadeusuarios();
    getUser();
    visivel = false;
    h();
  }

  reload() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: heithPorcent(94, context),
                    child: PageView(
                      onPageChanged: (thispage) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _PaginaAtual.value = thispage;
                      },
                      controller: page,
                      children: [Last(), Home(), Perfil()],
                    ),
                  ),
                  ButtonMenu()
                ],
              ),
            ),
            Load()
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
var _PaginaAtual = ValueNotifier<int>(1);

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var changeicon = ValueNotifier<int>(1);
    return ValueListenableBuilder(
        valueListenable: _PaginaAtual,
        builder: (_, a, b) {
          return Container(
            padding: EdgeInsets.only(
              bottom: heithPorcent(1, context),
            ),
            color: Color(0xFF113043),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    page.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: [
                      _PaginaAtual.value == 0
                          ? Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.white,
                            )
                          : Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                      Icon(
                        Icons.attractions_outlined,
                        size: heithPorcent(5, context),
                        color: _PaginaAtual.value != 0
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
                //
                GestureDetector(
                  onTap: () {
                    page.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: [
                      _PaginaAtual.value == 1
                          ? Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.white,
                            )
                          : Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                      Icon(
                        Icons.home,
                        size: heithPorcent(5, context),
                        color: _PaginaAtual.value != 1
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
                //
                GestureDetector(
                  onTap: () {
                    page.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: [
                      _PaginaAtual.value == 2
                          ? Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.white,
                            )
                          : Container(
                              height: heithPorcent(0.2, context),
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                      Icon(
                        Icons.person_outline_sharp,
                        size: heithPorcent(5, context),
                        color: _PaginaAtual.value != 2
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

bool visivel = true;
var reload = ValueNotifier<bool>(false);
bool isLoad = true;

class Load extends StatelessWidget {
  const Load({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: reload,
        builder: (_, a, b) {
          return isLoad
              ? Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Color(0XFF081720),
                      child: Center(
                        child: Container(
                          height: heithPorcent(0.5, context),
                          width: widthPorcent(50, context),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: heithPorcent(25, context)),
                      child: Center(
                        child: SizedBox(
                            height: heithPorcent(20, context),
                            child: Image.asset('imagems/logo.png')),
                      ),
                    ),
                    Positioned(
                      top: heithPorcent(49.73, context),
                      left: widthPorcent(25, context),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        height: heithPorcent(0.5, context),
                        width: visivel ? widthPorcent(50, context) : 0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : SizedBox();
        });
  }
}

h() async {
  await Future.delayed(Duration(milliseconds: 300));
  visivel = true;
  reload.value = !reload.value;
  await Future.delayed(Duration(milliseconds: 800));
  isLoad = false;
  reload.value = !reload.value;
}
