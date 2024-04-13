import 'package:flutter/material.dart';

class MemoryLevel {
  final double diameter;
  final double borderWidth;
  final Color borderColor1;
  final Color borderColor2;
  final double stop1;
  final double stop2;
  final int percent;
  final double fontSize;

  MemoryLevel(
      {required this.diameter,
      required this.borderWidth,
      required this.borderColor1,
      required this.borderColor2,
      required this.stop1,
      required this.stop2,
      required this.percent,
      required this.fontSize});
}

MemoryLevel level_1 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.orange,
    borderColor2: Colors.grey.shade300,
    stop1: 0.167,
    stop2: 0.168,
    percent: 1,
    fontSize: 12);

MemoryLevel level_2 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.yellow.shade700,
    borderColor2: Colors.grey.shade300,
    stop1: 0.34,
    stop2: 0.35,
    percent: 2,
    fontSize: 12);

MemoryLevel level_3 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.green.shade400,
    borderColor2: Colors.grey.shade300,
    stop1: 0.51,
    stop2: 0.52,
    percent: 3,
    fontSize: 12);

MemoryLevel level_4 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.green.shade700,
    borderColor2: Colors.grey.shade300,
    stop1: 0.667,
    stop2: 0.668,
    percent: 4,
    fontSize: 12);

MemoryLevel level_5 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.blue,
    borderColor2: Colors.grey.shade300,
    stop1: 0.835,
    stop2: 0.836,
    percent: 5,
    fontSize: 12);

MemoryLevel level_6 = MemoryLevel(
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.blue.shade800,
    borderColor2: Colors.grey.shade300,
    stop1: 1,
    stop2: 1,
    percent: 6,
    fontSize: 12);

class MemoryLevels {
  static const int level_1 = 1;
  static const int level_2 = 2;
  static const int level_3 = 3;
  static const int level_4 = 4;
  static const int level_5 = 5;
  static const int level_6 = 6;
}
