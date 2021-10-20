import 'dart:io';
import 'package:chat2/Pages/Editar_perfil.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:image_picker/image_picker.dart';

//variaveis\/
String backgraundPerfil = '';
String globalName = '';
String globalAvatar = '';
String globalGmail = '';
String story = '';
String data = '';
String hora = '';
Color appBackgroundcolor = Color(0xaa081720);
//Visitante \/
late String visitanteBackgraundPerfil;
late String visitanteNome;
late String visitanteglobalAvatar;

//Visitante /\

bool eGaleria = true;
//

FirebaseAuth auth = FirebaseAuth.instance;
void getUser() async {
  var resultado = await FirebaseFirestore.instance
      .collection('Dados dos Usuarios')
      .doc(auth.currentUser!.email.toString())
      .get()
      .whenComplete(() {
    changeUser.value = !changeUser.value;
  });

  globalName = resultado.get('NomeDoUsuario');
  globalAvatar = resultado.get('avatar');
  globalGmail = auth.currentUser!.email.toString();
  backgraundPerfil = resultado.get('back');
  story = resultado.get('story');
}

formatData() {
  var h = DateTime.now().hour.toString();
  var m = DateTime.now().minute.toString();
  //hora\/
  if (h.length == 1) {
    hora = '0$h';
  } else {
    hora = h;
  }
  //minuto\/
  if (m.length == 1) {
    hora = '0$hora:0$m';
  } else {
    hora = '$hora:$m';
  }

  if (DateTime.now().month == 1) {
    data = 'Jan/${DateTime.now().day}';
  } else if (DateTime.now().month == 2) {
    data = 'Fev/${DateTime.now().day}';
  } else if (DateTime.now().month == 3) {
    data = 'Mar/${DateTime.now().day}';
  } else if (DateTime.now().month == 4) {
    data = 'Abr/${DateTime.now().day}';
  } else if (DateTime.now().month == 5) {
    data = 'Maio/${DateTime.now().day}';
  } else if (DateTime.now().month == 6) {
    data = 'Jun/${DateTime.now().day}';
  } else if (DateTime.now().month == 7) {
    data = 'Jul${DateTime.now().day}';
  } else if (DateTime.now().month == 8) {
    data = 'Ago/${DateTime.now().day}';
  } else if (DateTime.now().month == 9) {
    data = 'Set/${DateTime.now().day}';
  } else if (DateTime.now().month == 10) {
    data = 'Out/${DateTime.now().day}';
  } else if (DateTime.now().month == 11) {
    data = 'Nov/${DateTime.now().day}';
  } else if (DateTime.now().month == 12) {
    data = 'Dez/${DateTime.now().day}';
  }
  data = '$data/${DateTime.now().year.toString().substring(2, 4)}';
}

criateID() {
  String idglobal;
  int millesecond = DateTime.now().millisecond;
  if (millesecond.toString().length == 1) {
    idglobal = '00$millesecond';
  } else if (millesecond.toString().length == 2) {
    idglobal = '0$millesecond';
  } else {
    idglobal = '$millesecond';
  }
  //
  int second = DateTime.now().second;
  if (second.toString().length == 1) {
    idglobal = '0$second' '$idglobal';
  } else {
    idglobal = '$second' '$idglobal';
  }
  //
  int minute = DateTime.now().minute;
  if (minute.toString().length == 1) {
    idglobal = '0$minute' '$idglobal';
  } else {
    idglobal = '$minute' '$idglobal';
  }
  //
  int hora = DateTime.now().hour;
  if (hora.toString().length == 1) {
    idglobal = '0$hora' '$idglobal';
  } else {
    idglobal = '$hora' '$idglobal';
  }
  int day = DateTime.now().day;
  if (day.toString().length == 1) {
    idglobal = '0$day' '$idglobal';
  } else {
    idglobal = '$day' '$idglobal';
  }
  //
  int math = DateTime.now().month;
  if (math.toString().length == 1) {
    idglobal = '0$math' '$idglobal';
  } else {
    idglobal = '$math' '$idglobal';
  }
  return '${DateTime.now().year}' '$idglobal';
}

getImage() async {
  var imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imagem == null) return null;
  return File(imagem.path);
}

uploadImage(File _thisimage, String endereso, String NameImage) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(endereso).child(NameImage);
  UploadTask uploadTask = ref.putFile(_thisimage);
  var url = await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
  return url.toString();
}

uploadlowImage(File _thisimage, String endereso) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage
      .ref()
      .child(endereso.toString())
      .child('low$endereso' + DateTime.now().toString());
  UploadTask uploadTask = ref.putFile(_thisimage);
  var url = await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
  return url.toString();
}

widthPorcent(double n, BuildContext context) {
  return MediaQuery.of(context).size.width / 100 * n;
}

heithPorcent(double n, BuildContext context) {
  return MediaQuery.of(context).size.height / 100 * n;
}

var changeUser = ValueNotifier<bool>(true);

compressImage(File file) async {
  // Get file path
  // eg:- "Volume/VM/abcd.jpeg"
  final filePath = file.absolute.path;
  double totalMB = file.readAsBytesSync().length / 1024 / 1024;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  var compressedImage = await FlutterImageCompress.compressAndGetFile(
    filePath,
    outPath,
    quality: 50,
  );
  print('Original:${file.readAsBytesSync().length / 1024 / 1024}Mb');
  print('final:${compressedImage!.readAsBytesSync().length / 1024 / 1024}Mb');
  return File(compressedImage.path);
}

getlistadeusuarios() async {
  listaDeusuarios =
      await FirebaseFirestore.instance.collection('Dados dos Usuarios').get();
}

var listaDeusuarios;

void updatetUserAvartar(File? thisImage, BuildContext context) async {
  String url = await uploadImage(thisImage!, globalGmail, 'avatar');
  FirebaseFirestore.instance
      .collection('Dados dos Usuarios')
      .doc(auth.currentUser!.email.toString())
      .update({
    'avatar': url,
  }).whenComplete(
    () async {
      getUser();
      loaduser.value = false;
      changeUser.value = !changeUser.value;
    },
  );
  posts.forEach(
    (element) {
      if (element['gmail'] == globalGmail && element['avatar'] != '') {
        FirebaseFirestore.instance
            .collection('Posts')
            .doc(element.id)
            .update({'avatar': url});
        print(url);
      }
    },
  );
}

void updatetUserNick(String thisnome, BuildContext context) async {
  if (thisnome != globalName) {
    FirebaseFirestore.instance
        .collection('Dados dos Usuarios')
        .doc(auth.currentUser!.email.toString())
        .update({'NomeDoUsuario': thisnome}).whenComplete(() async {
      getUser();
      loaduser.value = false;
      changeUser.value = !changeUser.value;
    }).whenComplete(() {
      posts.forEach((element) {
        if (element['gmail'] == globalGmail) {
          FirebaseFirestore.instance
              .collection('Posts')
              .doc(element.id)
              .update({'nome': thisnome});
        }
      });
    });
  }
}

void updatetUserStory(
  String thisStory,
  BuildContext context,
) async {
  if (thisStory != story) {
    FirebaseFirestore.instance
        .collection('Dados dos Usuarios')
        .doc(auth.currentUser!.email.toString())
        .update({'story': thisStory}).whenComplete(() async {
      getUser();
      print(thisStory);
      loaduser.value = false;
      changeUser.value = !changeUser.value;
    });
  }
}

upadatePost(String legenda, File? image) async {
  final String id;
  id = criateID();
  formatData();
  await FirebaseFirestore.instance.collection('Posts').doc(id).set({
    'favoritos': [],
    'id': id,
    'avatar': globalAvatar,
    'label': legenda,
    'hora': hora,
    'data': data,
    'nome': globalName,
    'gmail': globalGmail,
    'image': await uploadImage(image!, 'Posts', '${DateTime.now()}')
  });
}

favorito(String id) {
  FirebaseFirestore.instance.collection('Posts').doc(id).update({
    'favoritos': [globalGmail]
  });
}

desfavoritar(String id) {
  FirebaseFirestore.instance.collection('Posts').doc(id).update({
    'favoritos': FieldValue.arrayRemove([globalGmail])
  });
}
