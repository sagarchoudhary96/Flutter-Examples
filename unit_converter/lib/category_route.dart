import 'package:flutter/material.dart';
import 'package:unit_converter/category.dart';
import 'package:unit_converter/unit.dart';

final icon = Icons.cake;

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  State createState() => _CategoryRouteState();
}


class _CategoryRouteState extends State<CategoryRoute> {

  final _categories = <Category>[];

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];


  @override
  void initState() {
    super.initState();

    for (var i = 0; i < _categoryNames.length; i++) {
      _categories.add(Category(
        name: _categoryNames[i],
        icon: icon,
        color: _baseColors[i],
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
  }

  /// Build listView from caterogies list
  Widget _listViewBuilder() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => _categories[index],
      itemCount: _categories.length,
    );
  }

  /// Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  /// builds the category routes
  @override
  Widget build(BuildContext context) {

    final listView = Container(
      color: Colors.white10,
      child: _listViewBuilder(),
    );

    final appBar = AppBar(
      title: Text(
        "Unit Converter",
        style: TextStyle(fontSize: 25.0),
      ),
      centerTitle: true,
    );

    return Scaffold(appBar: appBar, body: listView);
  }
}
