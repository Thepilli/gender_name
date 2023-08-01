import 'package:flutter/material.dart';

class GenderCircle extends StatelessWidget {
  final String imgPath;
  final Color shadowColor;
  final bool isNotPicked;

  const GenderCircle({
    super.key,
    required this.imgPath,
    required this.shadowColor,
    required this.isNotPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            boxShadow: [BoxShadow(color: shadowColor, blurRadius: 30, offset: const Offset(0, 0))]),
        child: Image.asset(
          imgPath,
          fit: BoxFit.cover,
        ));
  }
}
