import 'package:flutter/material.dart';

/// A custom [Category] widget.
final _height = 100.0;

class Category extends StatelessWidget {
  /// name, color and icon for the category
  final String name;
  final IconData icon;
  final ColorSwatch color;
  const Category(
      {Key key, @required this.name, @required this.icon, @required this.color})
      : assert(name != null),
        assert(color != null),
        assert(icon != null),
        super(key: key);
  
  /// builds the category widget
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _height,
        child: InkWell(
          highlightColor: color,
          splashColor: color,
          onTap: () {
            print("hello");
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
