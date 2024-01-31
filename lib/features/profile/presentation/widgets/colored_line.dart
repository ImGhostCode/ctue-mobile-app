import 'package:flutter/material.dart';

class ColoredLine extends StatelessWidget {
  final double? length;
  final double percentLeft;
  final double percentRight;
  final Color colorLeft;
  final Color colorRight;

  const ColoredLine({
    super.key,
    this.length,
    required this.percentLeft,
    required this.percentRight,
    required this.colorLeft,
    required this.colorRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.0, // Adjust the height of the line as needed
      width: length ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorLeft, colorLeft, colorRight, colorRight],
          stops: [0.0, percentLeft, percentLeft, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
