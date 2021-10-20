// ignore_for_file: camel_case_types

import 'package:chat2/services/auth_service.dart';
import 'package:chat2/services/wigetsCustomizados.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Custonbutton(
              texto: Text('sair'),
              click: () {
                context.read<AuthServise>().logout();
              }),
        ),
      ),
    );
  }
}

var card = ValueNotifier<bool>(false);
