import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unit_converter/unit.dart';
import 'category.dart';
import 'api.dart';

const _padding = EdgeInsets.all(16.0);

class UnitConverter extends StatefulWidget {
  final Category category;

  const UnitConverter({@required this.category}) : assert(category != null);

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  /// variables for keeping track of the user's input
  // value and units
  Unit _fromValue;
  Unit _toValue;
  double _inputVal;
  String _convertedVal = '';
  List<DropdownMenuItem> _unitItems;
  bool _showError = false;
  final _inputKey = GlobalKey(debugLabel: "inputText");

  /// initial State
  @override
  void initState() {
    super.initState();
    _createDropDownItems();
    _setDefaultValues();
  }

  @override
  void didUpdateWidget(UnitConverter old) {
    super.didUpdateWidget(old);
    // We update our [DropdownMenuItem] units when we switch [Categories].
    if (old.category != widget.category) {
      _createDropDownItems();
      _setDefaultValues();
    }
  }

  /// Create DropDown menu of list of units
  void _createDropDownItems() {
    var dropDownItems = <DropdownMenuItem>[];
    for (var unit in widget.category.units) {
      dropDownItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));

      setState(() {
        _unitItems = dropDownItems;
      });
    }
  }

  /// set default unit value
  void _setDefaultValues() {
    setState(() {
      _fromValue = widget.category.units[0];
      _toValue = widget.category.units[1];
      if (_inputVal != null) {
        _updateConversion();
      }
    });
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  /// convert the input value
  void _updateConversion() async {
    if (widget.category.name == apiCategories['name']) {
      final api = Api();
      print("calling api: $_inputVal");
      final conversion = await api.convert(apiCategories['route'],
          _inputVal.toString(), _fromValue.name, _toValue.name);

      setState(() {
        _convertedVal = _format(conversion);
      });
    } else {
      setState(() {
        _convertedVal =
            _format(_inputVal * (_toValue.conversion / _fromValue.conversion));
      });
    }
  }

  void _updateInputVal(String value) {
    setState(() {
      if (value == null || value.isEmpty) {
        _convertedVal = '';
      } else {
        try {
          /// to check if user entered number only (safe check)
          final input = double.parse(value);
          _showError = false;
          _inputVal = input;
          _updateConversion();
        } on Exception catch (e) {
          print("error $e");
          _showError = true;
        }
      }
    });
  }

  Unit _getUnit(String unitName) {
    return widget.category.units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  /// update the values as soon we change value from input dropdown
  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });

    if (_inputVal != null) {
      _updateConversion();
    }
  }

  /// update the values as soon we change value from output dropdown
  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });

    if (_inputVal != null) {
      _updateConversion();
    }
  }

  /// Create input Widget
  Widget _inputWidget() {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ///Input Field
          TextField(
            key: _inputKey,
            autofocus: true,
            style: Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.display1,
                errorText: _showError ? "Invalid Number" : null,
                labelText: "Input",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                )),
            keyboardType: TextInputType.number,
            onChanged: _updateInputVal,
          ),
          _dropDownWidget(_fromValue.name, _updateFromConversion),
        ],
      ),
    );
  }

  /// Compare arrows icon.
  Widget _compareArrowWidget() {
    return RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );
  }

  /// Create output Widget
  Widget _outputWidget() {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            child: Text(
              _convertedVal,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.display1,
                labelText: "Output",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                )),
          ),
          _dropDownWidget(_toValue.name, _updateToConversion)
        ],
      ),
    );
  }

  /// Create DropDown Widget
  Widget _dropDownWidget(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(
            color: Colors.grey[500],
            width: 1.0,
          )),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
              canvasColor: Colors.grey[50],
            ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              items: _unitItems,
              value: currentValue,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final converter = ListView(
      children: <Widget>[
        _inputWidget(),
        _compareArrowWidget(),
        _outputWidget()
      ],
    );

    return Padding(
      padding: _padding,
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return converter;
        } else {
          return Center(
            child: Container(
              width: 450.0,
              child: converter,
            ),
          );
        }
      }),
    );
  }
}
