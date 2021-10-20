import 'package:chat2/services/funcoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  late String mensage;
  AuthException(this.mensage);
}

class AuthServise extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  AuthServise() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await _auth.signOut();
    getUser();
    backgraundPerfil = '';
    globalAvatar = '';
  }

  cadastro(String gmail, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: gmail, password: senha);
      getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Senha Muito Fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email ja cadastrado');
      }
    } catch (e) {}
  }

  login(String gmail, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: gmail,
        password: senha,
      );
      getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuario não encontrado');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha invalida');
      }
    }
  }
}
