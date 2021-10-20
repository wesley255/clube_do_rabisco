// ignore_for_file: implementation_imports, non_constant_identifier_names, unused_element

import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/src/provider.dart';
import 'services/funcoes.dart';
import 'package:chat2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  //bool \/
  bool Islogin = true;
  bool obiscure = false;
  //int \/
  int codApilido = 0;
  int codGmail = 0;
  int codSenha = 0;
  int codConSenha = 0;
  //string\/
  String _labelNick = 'Apelido';
  String _labelSenha = 'Senha';
  String _labelGmail = 'Gmail';
  //notifail \/
  var chack = ValueNotifier(true);
  //controller \/
  TextEditingController _controllerGmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerApelido = TextEditingController();
  TextEditingController _controllerConfirmarSenha = TextEditingController();
  _Vadidade(int cod) {
    if (cod == 0) {
      return Icon(Icons.check_circle_outlined, color: Colors.grey);
    } else if (cod == 1) {
      return Icon(Icons.check_circle_rounded, color: Colors.greenAccent);
    } else {
      return Icon(Icons.close, color: Colors.redAccent);
    }
  }

  _saveUser() {
    FirebaseFirestore.instance
        .collection('Dados dos Usuarios')
        .doc(_controllerGmail.text)
        .set({
      'NomeDoUsuario': _controllerApelido.text,
      'avatar': '',
      'back': '',
      'story': '',
      'gmail': _controllerGmail.text,
      'user': _controllerApelido.text
    });
  }

  _login() async {
    try {
      await context
          .read<AuthServise>()
          .login(_controllerGmail.text, _controllerSenha.text);
    } on AuthException catch (e) {
      if (e.mensage == 'Usuario não encontrado') {
        codGmail = 2;
        chack.value = !chack.value;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.mensage)));
      } else if (e.mensage == 'Senha invalida') {
        _controllerSenha.text = '';
        codSenha = 2;
        _labelSenha = '${e.mensage}';
        chack.value = !chack.value;
      }
    }
  }

  getlistuser() async {
    bool nickvalido = true;
    int index = 0;

    if (listaDeusuarios.docs.isEmpty) {
      cadastro();
      _saveUser();
    }
    listaDeusuarios.docs.forEach((element) {
      if (element['NomeDoUsuario'].toString().toUpperCase() ==
          _controllerApelido.text.toUpperCase()) {
        nickvalido = false;
      } else {}
      index++;
      if (index == listaDeusuarios.docs.length) {
        if (nickvalido) {
          cadastro();
          _saveUser();
        } else {
          _controllerApelido.text = '';
          codApilido = 2;
          _labelNick = 'O apelido já esta em uso';
          chack.value = !chack.value;
        }
      }
    });
  }

  cadastro() async {
    try {
      await context
          .read<AuthServise>()
          .cadastro(_controllerGmail.text, _controllerSenha.text);
    } on AuthException catch (e) {
      if (e.mensage == 'Email ja cadastrado') {
        _controllerGmail.text = '';
        _labelGmail = 'Email ja cadastrado';
        codGmail = 2;
        chack.value = !chack.value;
      }
    }
  }

  cleanAllController() {
    _controllerApelido.text = '';
    _controllerConfirmarSenha.text = '';
    _controllerGmail.text = '';
    _controllerSenha.text = '';
  }

  @override
  void initState() {
    super.initState();
    cleanAllController();
    getlistadeusuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: heithPorcent(100, context),
          width: widthPorcent(100, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('imagems/backgrond.png'),
                  fit: BoxFit.cover)),
        ),
        Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ValueListenableBuilder(
              valueListenable: chack,
              builder: (a, b, c) {
                return Container(
                  padding: EdgeInsets.only(top: 100),
                  margin: EdgeInsets.symmetric(
                      horizontal: widthPorcent(6, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Image.asset(
                          'imagems/logo.png',
                          scale: widthPorcent(0.8, context),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: heithPorcent(2, context)),
                          child: Text(
                            'Clube do Rabisco',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widthPorcent(7, context)),
                          ),
                        ),
                      ),
                      !Islogin
                          ? CaixaDeTexto(
                              label: _labelNick,
                              controller: _controllerApelido,
                              onChanged: (t) {
                                if (t.toString().length == 0) {
                                  codApilido = 0;
                                  chack.value = !chack.value;
                                } else if (t.toString().length > 3) {
                                  _Vadidade(1);
                                  codApilido = 1;
                                  chack.value = !chack.value;
                                } else {
                                  codApilido = 2;
                                  chack.value = !chack.value;
                                }
                              },
                              borderRadius: 10,
                              icon: _Vadidade(codApilido))
                          : SizedBox(),
                      CaixaDeTexto(
                          keyboardType: TextInputType.emailAddress,
                          label: _labelGmail,
                          controller: _controllerGmail,
                          onChanged: (t) {
                            if (t == '') {
                              codGmail = 0;
                              chack.value = !chack.value;
                            } else if ((t.toString().contains('@gmail.com') ||
                                    t.toString().contains('@ymail.com')) &&
                                t.toString().length > 7) {
                              codGmail = 1;
                              chack.value = !chack.value;
                            } else {
                              codGmail = 2;
                              chack.value = !chack.value;
                            }
                          },
                          borderRadius: 10,
                          icon: _Vadidade(codGmail)),
                      CaixaDeTexto(
                          label: _labelSenha,
                          obiscureText: !obiscure,
                          controller: _controllerSenha,
                          onChanged: (t) {
                            if (t == '') {
                              if (_controllerConfirmarSenha.text == '') {
                                codConSenha = 0;
                              }
                              codSenha = 0;
                              chack.value = !chack.value;
                            } else if (t.toString().length >= 8) {
                              codSenha = 1;
                              if (t != _controllerConfirmarSenha.text) {
                                codConSenha = 2;
                              } else {
                                codConSenha = 1;
                              }
                              chack.value = !chack.value;
                            } else {
                              codSenha = 2;
                              codConSenha = 2;
                              chack.value = !chack.value;
                            }
                          },
                          borderRadius: 10,
                          icon: _Vadidade(codSenha)),
                      !Islogin
                          ? CaixaDeTexto(
                              label: 'Confirmar Senha',
                              obiscureText: !obiscure,
                              controller: _controllerConfirmarSenha,
                              onChanged: (t) {
                                if (t == '') {
                                  codConSenha = 0;
                                  chack.value = !chack.value;
                                } else if (t.toString().length >= 8 &&
                                    _controllerSenha.text ==
                                        _controllerConfirmarSenha.text) {
                                  codConSenha = 1;
                                  chack.value = !chack.value;
                                } else {
                                  codConSenha = 2;
                                  chack.value = !chack.value;
                                }
                              },
                              borderRadius: 10,
                              icon: _Vadidade(codConSenha),
                            )
                          : SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                              value: obiscure,
                              onChanged: (o) {
                                obiscure = o!;
                                chack.value = !chack.value;
                              }),
                          Text('Exibir senha')
                        ],
                      ),
                      Custonbutton(
                          texto: Islogin
                              ? Text(
                                  'Login',
                                  style: TextStyle(fontSize: 30),
                                )
                              : Text(
                                  'Cadatrar',
                                  style: TextStyle(fontSize: 30),
                                ),
                          click: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (Islogin) {
                              if (codSenha == 1 && codGmail == 1) {
                                _login();
                              } else if (codSenha == 1 &&
                                  codGmail == 1 &&
                                  codApilido == 1 &&
                                  codConSenha == 1) {
                                print('correto');
                              }
                            } else {
                              if (codConSenha == 1 &&
                                  codSenha == 1 &&
                                  codGmail == 1 &&
                                  codApilido == 1) {
                                getlistuser();
                              }
                            }
                          }),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Islogin
                                  ? heithPorcent(20, context)
                                  : heithPorcent(9, context)),
                          child: GestureDetector(
                            onTap: () {
                              Islogin = !Islogin;
                              chack.value = !chack.value;
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: Islogin
                                          ? 'Ainda Não Tenho Conta\n'
                                          : 'Voltar para\n'),
                                  TextSpan(
                                      text: Islogin
                                          ? 'CRIAR UMA AGORA'
                                          : 'Tela de Login')
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
