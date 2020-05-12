import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripCost calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  String _currency = 'Dollars';
  final double _formDistance = 5.0;

  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void _onDropdownChange(String value) {
    setState(() {
      this._currency = value;
    });
  }

  TextField _distanceField(TextStyle textStyle) {
    return TextField(
      controller: distanceController,
      decoration: InputDecoration(
          hintText: "e.g. 124",
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: "Distance"),
      keyboardType: TextInputType.number,
    );
  }

  Padding _twoColsWidgets(Widget w1, Widget w2) {
    return Padding(
        padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
        child: Row(
          children: <Widget>[
            Expanded(
              child: w1,
            ),
            Container(width: _formDistance * 5),
            Expanded(
              child: w2,
            )
          ],
        ));
  }

  TextField _distancePerUnit(TextStyle textStyle) {
    return TextField(
      controller: avgController,
      decoration: InputDecoration(
          hintText: "e.g. 17",
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: "Distance per unit"),
      keyboardType: TextInputType.number,
    );
  }

  TextField _priceUnit(TextStyle textStyle) {
    return TextField(
      controller: priceController,
      decoration: InputDecoration(
          hintText: "e.g. 1.65",
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: "Price"),
      keyboardType: TextInputType.number,
    );
  }

  DropdownButton _currencyOption() {
    return DropdownButton<String>(
      items: _currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _currency,
      onChanged: (String value) {
        _onDropdownChange(value);
      },
    );
  }

  RaisedButton _calculateButton() {
    return RaisedButton(
      color: Theme.of(context).primaryColorDark,
      textColor: Theme.of(context).primaryColorLight,
      child: Text(
        'Calculate it!',
        textScaleFactor: 1.5,
      ),
      onPressed: () {
        setState(() {
          result = _calculate();
        });
      },
    );
  }

  RaisedButton _resetButton() {
    return RaisedButton(
      color: Theme.of(context).buttonColor,
      textColor: Theme.of(context).primaryColorDark,
      child: Text(
        'Reset',
        textScaleFactor: 1.5,
      ),
      onPressed: () {
        setState(() {
          _reset();
        });
      },
    );
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = "The total cost of your trip is: " +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            _twoColsWidgets(
                _distanceField(textStyle), _distancePerUnit(textStyle)),
            _twoColsWidgets(_priceUnit(textStyle), _currencyOption()),
            _twoColsWidgets(_calculateButton(), _resetButton()),
            Text(result)
          ],
        ),
      ),
    );
  }
}
