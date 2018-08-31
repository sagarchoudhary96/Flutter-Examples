import 'dart:math';

import 'package:flutter/material.dart';

class ColorPalette {
  static final ColorPalette primary = ColorPalette(<Color>[
    Colors.blue[400],
    Colors.red[400],
    Colors.green[400],
    Colors.yellow[400],
    Colors.orange[400],
    Colors.teal[400],
    Colors.indigo[400],
  ]);

  final List<Color> colors;

  ColorPalette(this.colors) : assert(colors != null);

  Color operator [] (int index) => colors[index%length];

  int get length => colors.length;

  Color random(Random random) => this[random.nextInt(length)];
}
