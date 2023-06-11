import 'dart:ui';

import 'package:flutter/material.dart';

String? text;
double? size;
Color? color;

//color value
const mainColor = Colors.white;

// fonts
class MainText extends StatelessWidget {
  const MainText(
      {super.key,
      required this.title,
      required this.size,
      required this.color,
      this.align,
      this.fnt});

  final String title;
  final double size;
  final Color color;
  final TextAlign? align;
  final FontWeight? fnt;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: fnt,
        color: color,
      ),
    );
  }
}
