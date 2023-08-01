import 'package:flutter/material.dart';
import 'package:gender_name/constants/colors.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.lightBackground, AppColors.lightBackgroundontainer],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
