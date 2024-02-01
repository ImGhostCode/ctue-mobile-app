import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final double diameter;
  final double borderWidth;
  final Color borderColor1;
  final Color borderColor2;
  final double stop1;
  final double stop2;
  final int percent;
  final double fontSize;

  const GradientBorderContainer(
      {required this.diameter,
      required this.borderWidth,
      required this.borderColor1,
      required this.borderColor2,
      required this.stop1,
      required this.stop2,
      required this.percent,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [borderColor1, borderColor2],
          stops: [stop1, stop2],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(diameter * borderWidth),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Inner color
        ),
        child: Center(
          child: Text(
            '$percent',
            style: TextStyle(fontSize: fontSize, color: borderColor1),
          ),
        ),
      ),
    );
  }
}
