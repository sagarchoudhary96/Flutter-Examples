import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unit_converter/unit.dart';

class Category {
  /// name, color and icon for the category
  final String name;
  final String icon;
  final ColorSwatch color;
  final List<Unit> units;
  const Category(
      {@required this.name,
      @required this.icon,
      @required this.color,
      @required this.units})
      : assert(name != null),
        assert(color != null),
        assert(icon != null),
        assert(units != null);
}
