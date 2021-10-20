import 'package:chat2/services/funcoes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getPosts() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .orderBy('id', descending: true)
      .snapshots();
}

Stream<QuerySnapshot> getMyPosts() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .where('gmail', isEqualTo: globalGmail)
      .snapshots();
}

Stream<QuerySnapshot> getfavoritos() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .where('favoritos', arrayContains: auth.currentUser!.email.toString())
      .snapshots();
}

Stream<QuerySnapshot> getlistUser() {
  return FirebaseFirestore.instance
      .collection('Dados dos Usuarios')
      .snapshots();
}

List<DocumentSnapshot> listUser = [];
List<DocumentSnapshot> myfavoritos = [];
List<DocumentSnapshot> posts = [];
List<DocumentSnapshot> myposts = [];
