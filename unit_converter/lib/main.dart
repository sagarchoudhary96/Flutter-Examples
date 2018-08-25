import 'package:flutter/material.dart';
import 'package:unit_converter/category.dart';

const _categoryName = 'Cake';
const _categoryIcon = Icons.cake;
const _categoryColor = Colors.greenAccent;

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.
class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Unit Converter",
            style: TextStyle(fontSize: 25.0),
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Center(
          // TODO: Determine what properties you'll need to pass into the widget
          child: Category(
              name: _categoryName, icon: _categoryIcon, color: _categoryColor),
        ),
      ),
    );
  }
}
