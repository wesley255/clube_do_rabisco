// ignore_for_file: unused_element, override_on_non_overriding_member

import 'dart:io';
import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:flutter/material.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({Key? key}) : super(key: key);

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  File? _testAvatar;
  @override
  String _nickLabel = '';
  _getlistuser() async {
    if (_NickController.text.toUpperCase() == globalName.toUpperCase()) {
      return;
    }
    bool nickvalido = true;
    int index = 0;
    listaDeusuarios.docs.forEach((element) {
      if (element['user'].toString().toUpperCase() ==
          newNick.toString().toUpperCase()) {
        nickvalido = false;
      } else {}
      index++;
      if (index == listaDeusuarios.docs.length) {
        if (nickvalido) {
          loaduser.value = true;
          updatetUserNick(_NickController.text, context);
        } else {
          _NickController.text = '';
          setState(() {
            _nickLabel = 'Nick Ja existe!';
            FocusScope.of(context).requestFocus(new FocusNode());
          });
        }
      }
    });
  }

  void initState() {
    super.initState();
    getlistadeusuarios();
    _storycontroller.text = story;
    _NickController.text = globalName;
    _gmailController.text = globalGmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF081720),
        centerTitle: true,
        title: H2(text: 'Editar Perfil'),
      ),
      backgroundColor: Color(0xFF081720),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: heithPorcent(80, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: heithPorcent(14, context),
                            width: widthPorcent(30, context),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: heithPorcent(7, context),
                          ),
                          //avatar phonto\/
                          ValueListenableBuilder(
                              valueListenable: changeUser,
                              builder: (_, a, b) {
                                return globalAvatar == '' && _testAvatar == null
                                    ? CircleAvatar(
                                        radius: heithPorcent(6.6, context),
                                        backgroundImage:
                                            AssetImage('imagems/avatar.png'),
                                      )
                                    : _testAvatar == null
                                        ? CircleAvatar(
                                            radius: heithPorcent(6.6, context),
                                            backgroundImage:
                                                NetworkImage(globalAvatar),
                                          )
                                        : CircleAvatar(
                                            radius: heithPorcent(6.6, context),
                                            backgroundImage:
                                                FileImage(_testAvatar!),
                                          );
                              }),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: heithPorcent(2.3, context),
                              backgroundColor: Colors.white,
                              child: GestureDetector(
                                onTap: () async {
                                  _testAvatar = await getImage();
                                  setState(() {
                                    _testAvatar;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: heithPorcent(2, context),
                                  backgroundColor: Colors.lightBlue,
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFF010C10),
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      width: widthPorcent(95, context),
                      height: heithPorcent(10, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              H2(text: 'Nick Name'),
                              _nickLabel == ''
                                  ? Icon(Icons.edit_outlined)
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )
                            ],
                          ),
                          CaixaDeTexto(
                            label: _nickLabel,
                            color: Color(0xFF010C10),
                            controller: _NickController,
                            onChanged: (t) {
                              newNick = _NickController.text;
                              if (_nickLabel != '') {
                                _nickLabel = '';
                              }
                            },
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFF010C10),
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      width: widthPorcent(95, context),
                      height: heithPorcent(10, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              H2(text: 'Gmail'),
                              Icon(Icons.edit_outlined)
                            ],
                          ),
                          CaixaDeTexto(
                            controller: _gmailController,
                            onChanged: (t) => newGmail = _gmailController.text,
                            color: Color(0xFF010C10),
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFF010C10),
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      width: widthPorcent(95, context),
                      height: heithPorcent(20, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              H2(text: 'Story'),
                              Icon(Icons.edit_outlined)
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: heithPorcent(15, context)),
                            child: TextField(
                              onChanged: (t) => newStory = t,
                              controller: _storycontroller,
                              maxLines: null,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Custonbutton(
                        texto: Text(
                          'Comfirmar',
                          style: TextStyle(fontSize: 30),
                        ),
                        click: () async {
                          if (_testAvatar != null) {
                            loaduser.value = true;
                            _testAvatar = await compressImage(_testAvatar!);
                            updatetUserAvartar(_testAvatar, context);
                          }
                          _getlistuser();

                          if (story != newStory) {
                            loaduser.value = true;
                            updatetUserStory(_storycontroller.text, context);
                          }
                        }),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: loaduser,
                builder: (_, a, b) {
                  return loaduser.value
                      ? Container(
                          padding: EdgeInsets.only(
                              bottom: heithPorcent(30, context)),
                          height: heithPorcent(100, context),
                          width: widthPorcent(100, context),
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(microseconds: 200),
                              height: loaduser.value
                                  ? heithPorcent(20, context)
                                  : 0,
                              width: widthPorcent(80, context),
                              color: Color(0xFF081720),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Savando Dados..',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String newStory = '';
String newGmail = '';
String newNick = '';

var loaduser = ValueNotifier<bool>(false);
TextEditingController _storycontroller = TextEditingController();
TextEditingController _gmailController = TextEditingController();
TextEditingController _NickController = TextEditingController();
