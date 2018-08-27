import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unit_converter/unit.dart';
import 'package:unit_converter/converter_route.dart';

/// A custom [Category] widget.
final _height = 100.0;

class Category extends StatelessWidget {
  /// name, color and icon for the category
  final String name;
  final IconData icon;
  final ColorSwatch color;
  final List<Unit> units;
  const Category(
      {Key key,
      @required this.name,
      @required this.icon,
      @required this.color,
      @required this.units})
      : assert(name != null),
        assert(color != null),
        assert(icon != null),
        assert(units != null),
        super(key: key);

  /// Navigates to the ConverterRoute.
  void _navigateToConverter(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text(
            name,
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: color,
        ),
        body: ConverterRoute(units: units, name: name, color: color),
        resizeToAvoidBottomPadding: false,
      );
    }));
  }

  /// builds the category widget
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _height,
        child: InkWell(
          highlightColor: color['highlight'],
          splashColor: color['splash'],
          onTap: () {
            _navigateToConverter(context);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
