import 'package:flutter/material.dart';

class WidthBox extends StatelessWidget {
  const WidthBox({super.key, required this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
