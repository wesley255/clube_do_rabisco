import 'package:chat2/Pages/Pageview.dart';
import 'package:chat2/login.dart';
import 'package:chat2/services/auth_service.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  @override
  Widget build(BuildContext context) {
    AuthServise auth = Provider.of<AuthServise>(context);
    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return Login();
    } else {
      return Pages();
    }
  }
}

loading() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
