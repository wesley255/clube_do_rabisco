// ignore_for_file: unused_local_variable, override_on_non_overriding_member

import 'package:chat2/Pages/Pageview.dart';
import 'package:chat2/services/funcoes.dart';
import 'package:chat2/services/streamFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaixaDeTexto extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margem;
  final VoidCallback? iconClick;
  final Function? onChanged;
  final String? label;
  final Color? color;
  final Widget? icon;
  final double? borderRadius;
  final bool? muiltline;
  final bool? obiscureText;
  final TextInputType? keyboardType;
  final Color? textColor;
  final double? width;
  final Color? bordercolor;
  final double? borderLaft;
  final double? borderRiad;
  final double? bordertopLaft;
  final double? borderTopRiad;
  final double? borderall;
  final double? heith;
  final bool? textCenter;

  const CaixaDeTexto({
    this.controller,
    this.onChanged,
    this.label,
    this.margem,
    this.iconClick,
    this.icon,
    this.borderRadius,
    this.muiltline,
    this.obiscureText,
    this.keyboardType,
    this.color,
    this.textColor,
    this.width,
    this.bordercolor,
    this.borderLaft,
    this.borderRiad,
    this.bordertopLaft,
    this.borderTopRiad,
    this.borderall,
    this.heith,
    this.textCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(),
        margin: margem == null ? EdgeInsets.all(5) : margem,
        constraints: BoxConstraints(
            maxHeight: 150, maxWidth: width ?? widthPorcent(99, context)),
        child: Stack(
          children: [
            //border stlyle\/
            ClipRRect(
              borderRadius: borderRadius == null
                  ? BorderRadius.only(
                      bottomLeft: borderLaft == null
                          ? Radius.circular(0)
                          : Radius.circular(borderLaft!),
                      bottomRight: borderRiad == null
                          ? Radius.circular(0)
                          : Radius.circular(borderRiad!),
                      topLeft: bordertopLaft == null
                          ? Radius.circular(0)
                          : Radius.circular(bordertopLaft!),
                      topRight: borderTopRiad == null
                          ? Radius.circular(0)
                          : Radius.circular(borderTopRiad!),
                    )
                  : BorderRadius.circular(borderRadius!),
              //border style/\
              child: TextField(
                obscureText: obiscureText == null ? false : obiscureText!,
                // Text Style\/
                style: TextStyle(
                  color: textColor == null ? Colors.black : textColor,
                ),
                //text style /\
                //funcoes\/
                maxLines: muiltline == null ? 1 : null,
                onChanged: (e) {
                  if (onChanged != null) {
                    onChanged!(e);
                  }
                },
                keyboardType: keyboardType,
                controller: controller,

                //funcoes/\
                //style input \/
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: bordercolor == null
                        ? BorderSide.none
                        : BorderSide(color: bordercolor!),
                  ),
                  label: label != null ? H2(text: label!) : Text(''),
                  filled: true,
                  fillColor: color ?? Colors.white,
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                      right: 40,
                      bottom: 8,
                      top: heith == null ? 8 : heith!,
                      left: 5),
                ),
              ),
            ),
            //icone\/
            Positioned(
              top: -6,
              right: -2,
              child: icon != null
                  ? IconButton(onPressed: iconClick, icon: icon!)
                  : SizedBox(),
            ),
            //icone/\
          ],
        ));
  }
}

class Custonbutton extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry? margem;
  final Widget texto;
  final Icon? icone;
  final VoidCallback click;
  final double? heith;
  final double? width;

  const Custonbutton(
      {this.color,
      required this.texto,
      this.icone,
      required this.click,
      this.margem,
      this.heith,
      this.width});

  @override
  Widget build(BuildContext context) {
    double _size = widthPorcent(30, context);
    return GestureDetector(
      onTap: click,
      child: Container(
        margin: margem == null ? EdgeInsets.all(5) : margem,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: color == null ? Color(0xFF4AA4D4) : color!),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: icone != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 3), child: texto),
                    icone == null ? Container() : icone!,
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: heith ?? 0, horizontal: width ?? 0),
                  child: texto,
                ),
        ),
      ),
    );
  }
}

class CheckBoxCuston extends StatelessWidget {
  final Text? label;

  final ValueChanged<bool?>? onChanged;

  // ignore: non_constant_identifier_names
  const CheckBoxCuston({this.label, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var chenge = ValueNotifier<bool>(false);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      ValueListenableBuilder(
          valueListenable: chenge,
          builder: (a, b, c) {
            return GestureDetector(
                onTap: () {
                  chenge.value = !chenge.value;
                  onChanged!(chenge.value);
                },
                child: Row(
                  children: [
                    chenge.value
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank),
                    label == null ? SizedBox() : label!
                  ],
                ));
          })
    ]);
  }
}

class H2 extends StatelessWidget {
  final String text;
  final double? size;
  const H2({required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Color(0xffAEAEAE), fontSize: size == null ? 15 : size),
    );
  }
}

Color h2color = Color(0xffAEAEAE);

class GaleriaGrid extends StatelessWidget {
  final BuildContext context;

  final EdgeInsets? margem;
  final Function? onTap;
  final String? buttonText;

  //
  final Stream<QuerySnapshot<Object?>> stream;
  List<DocumentSnapshot> documentSnapshot;
  GaleriaGrid(
      {required this.context,
      this.margem,
      this.buttonText,
      this.onTap,
      required this.stream,
      required this.documentSnapshot});

  @override
  Widget build(BuildContext _context) {
    var change = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: change,
      builder: (_context, _value, _child) {
        return Padding(
          padding: margem ?? EdgeInsets.zero,
          child: Column(
            children: [
              //button\/
              buttonText != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 2),
                      child: GestureDetector(
                        onTap: () => change.value = !change.value,
                        child: Row(
                          children: [
                            Text(
                              buttonText!,
                              style: TextStyle(
                                  fontSize: widthPorcent(5, context),
                                  fontWeight: FontWeight.bold),
                            ),
                            change.value
                                ? Icon(Icons.keyboard_arrow_up_outlined)
                                : Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              //button/\
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Container(
                  padding: EdgeInsets.all(heithPorcent(1, context)),
                  width: widthPorcent(100, context),
                  color: Color(0xFF182C38),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: stream,
                      builder: (_, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            documentSnapshot = snapshot.data!.docs;

                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              //lanth\/
                              itemCount: change.value
                                  ? documentSnapshot.length
                                  : documentSnapshot.length < 8
                                      ? documentSnapshot.length
                                      : 8,
                              //lanth/\
                              padding: EdgeInsetsDirectional.all(0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 1,
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 1),
                              itemBuilder: (_, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.docs[
                                            (documentSnapshot.length - 1) -
                                                index]['image']),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
