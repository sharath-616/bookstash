import 'package:flutter/material.dart';

class CustomTextWidgets extends StatelessWidget {
  final String text;
  final Color? clr;
  final double? fz;
  final double? lp;
  final FontWeight? fw;
  const CustomTextWidgets({super.key, required this.text, this.clr, this.fz, this.lp, this.fw});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: clr, fontSize: fz, fontWeight: fw, letterSpacing: lp),
    );
  }
}
