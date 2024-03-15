

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Resources/style_manager.dart';

class MyText extends StatelessWidget {
  final String text;
  double size = 14;
  bool bold = false;
  Color color = Colors.black;
  int lines = 99;
  final TextStyle style;

  MyText({super.key, required this.text, this.size = 14,this.lines = 99, this.style = const TextStyle() });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        fontSize: size,
      ),
      maxLines: lines,
    );
  }
}
