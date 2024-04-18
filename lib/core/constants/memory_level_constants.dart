import 'package:flutter/material.dart';

class MemoryLevel {
  final double diameter;
  final double borderWidth;
  final Color borderColor1;
  final Color borderColor2;
  final Color color;
  final double stop1;
  final double stop2;
  final int percent;
  final double fontSize;
  final String title;

  MemoryLevel(
      {required this.diameter,
      required this.borderWidth,
      required this.borderColor1,
      required this.borderColor2,
      required this.color,
      required this.stop1,
      required this.title,
      required this.stop2,
      required this.percent,
      required this.fontSize});
}

MemoryLevel level_1 = MemoryLevel(
    title: '1',
    diameter: 20,
    borderWidth: 0.10,
    borderColor1: Colors.orange,
    color: Colors.orange,
    borderColor2: Colors.grey.shade300,
    stop1: 0.167,
    stop2: 0.168,
    percent: 16,
    fontSize: 10);

MemoryLevel level_2 = MemoryLevel(
    title: '2',
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.yellow.shade700,
    color: Colors.yellow.shade700,
    borderColor2: Colors.grey.shade300,
    stop1: 0.34,
    stop2: 0.35,
    percent: 33,
    fontSize: 10);

MemoryLevel level_3 = MemoryLevel(
    title: '3',
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.green.shade400,
    color: Colors.green.shade400,
    borderColor2: Colors.grey.shade300,
    stop1: 0.51,
    stop2: 0.52,
    percent: 50,
    fontSize: 10);

MemoryLevel level_4 = MemoryLevel(
    title: '4',
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.green.shade700,
    color: Colors.green.shade700,
    borderColor2: Colors.grey.shade300,
    stop1: 0.667,
    stop2: 0.668,
    percent: 66,
    fontSize: 10);

MemoryLevel level_5 = MemoryLevel(
    title: '5',
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.blue,
    color: Colors.blue,
    borderColor2: Colors.grey.shade300,
    stop1: 0.835,
    stop2: 0.836,
    percent: 83,
    fontSize: 10);

MemoryLevel level_6 = MemoryLevel(
    title: '6',
    diameter: 20,
    borderWidth: 0.12,
    borderColor1: Colors.blue.shade800,
    color: Colors.blue.shade800,
    borderColor2: Colors.grey.shade300,
    stop1: 1,
    stop2: 1,
    percent: 100,
    fontSize: 10);

class MemoryLevels {
  static const int level_1 = 1;
  static const int level_2 = 2;
  static const int level_3 = 3;
  static const int level_4 = 4;
  static const int level_5 = 5;
  static const int level_6 = 6;
}
