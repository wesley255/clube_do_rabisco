// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/wigetsCustomizados.dart';
import 'package:flutter/material.dart';

class CreateDesafil extends StatefulWidget {
  const CreateDesafil({Key? key}) : super(key: key);

  @override
  _CreateDesafilState createState() => _CreateDesafilState();
}

class _CreateDesafilState extends State<CreateDesafil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF081720),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: changeImagem,
                      builder: (_, a, b) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () async {
                                _TestimageCardDesafil = await getImage();
                                changeImagem.value = !changeImagem.value;
                              },
                              child: _TestimageCardDesafil == null
                                  ? Container(
                                      height: heithPorcent(20, context),
                                      width: double.infinity,
                                      color: Color(0xFF4F4F4F),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.photo_camera_back_outlined,
                                              size: 50,
                                            ),
                                            H2(
                                                text:
                                                    'Adicionar Imagem de Fundo')
                                          ],
                                        ),
                                      ))
                                  : GestureDetector(
                                      onTap: () async {
                                        _TestimageCardDesafil =
                                            await getImage();
                                        changeImagem.value =
                                            !changeImagem.value;
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: heithPorcent(20, context),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                    _TestimageCardDesafil!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }),
                  // titulo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: heithPorcent(10, context),
                        width: double.infinity,
                        color: Color(0xFF4010C10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            H2(text: 'Titulo'),
                            TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Desafil',
                                  border: InputBorder.none),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Regras/Descrição\/
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: heithPorcent(24, context),
                      ),
                      padding: EdgeInsets.all(10),
                      height: heithPorcent(25, context),
                      width: double.infinity,
                      color: Color(0xFF010C10),
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Regras/Descrição',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

var changeImagem = ValueNotifier<bool>(true);
File? _TestimageCardDesafil;
