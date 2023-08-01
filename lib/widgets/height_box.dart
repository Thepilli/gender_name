import 'package:flutter/material.dart';

class HeightBox extends StatelessWidget {
  const HeightBox({super.key, required this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
