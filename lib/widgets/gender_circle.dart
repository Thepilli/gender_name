import 'package:flutter/material.dart';

class GenderCircle extends StatefulWidget {
  final String imgPath;
  final Color shadowColor;
  final bool isPicked;

  const GenderCircle({
    super.key,
    required this.imgPath,
    required this.shadowColor,
    required this.isPicked,
  });

  @override
  State<GenderCircle> createState() => _GenderCircleState();
}

class _GenderCircleState extends State<GenderCircle> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation; //to animate a color, a 0-1 values are not sufficient,therefore we need aditional object
  late Animation<double> curve; //to animate a color, a 0-1 values are not sufficient,therefore we need aditional object
  final isVisible = true;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    ); //emits the value between 0-1 over the duration period

    curve = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: widget.shadowColor,
    ).animate(controller); //allows to get values between grey and red, instead of 0-1
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPicked = widget.isPicked;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      height: isPicked ? 200 : 120,
      decoration: BoxDecoration(
        border: isPicked ? null : Border.all(color: widget.shadowColor.withOpacity(.5), width: 5),
        borderRadius: BorderRadius.circular(90),
        boxShadow: [
          BoxShadow(
            color: isPicked ? widget.shadowColor : Colors.transparent,
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Opacity(
        opacity: 1,
        child: Image.asset(
          widget.imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
