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
      .where('userKey', isEqualTo: userKey)
      .snapshots();
}

Stream<QuerySnapshot> getVisitantePosts() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .where('gmail', isEqualTo: visitantegmail)
      .snapshots();
}

Stream<QuerySnapshot> getMyfavoritos() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .where('favoritos', arrayContains: auth.currentUser!.email.toString())
      .snapshots();
}

Stream<QuerySnapshot> getVisitantefavoritos() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .where('favoritos', arrayContains: visitantegmail)
      .snapshots();
}

Stream<QuerySnapshot> getlistUser() {
  return FirebaseFirestore.instance
      .collection('Dados dos Usuarios')
      .snapshots();
}

Stream<QuerySnapshot> getComentarios() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .doc(Idcomentario!)
      .collection('comentarios')
      .snapshots();
}

String? Idcomentario;
List<DocumentSnapshot> listComentarios = [];
List<DocumentSnapshot> listUser = [];
List<DocumentSnapshot> myfavoritos = [];
List<DocumentSnapshot> posts = [];
List<DocumentSnapshot> myposts = [];
