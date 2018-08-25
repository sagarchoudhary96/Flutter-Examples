import 'package:meta/meta.dart';

class Unit {
  final String name;
  final double conversion;

  const Unit({
    @required this.name,
    @required this.conversion,
  })  : assert(name != null),
        assert(conversion != null);

  Unit.fromJson(Map jsonMap)
      : name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble(),
        assert(name != null),
        assert(conversion != null);
}
