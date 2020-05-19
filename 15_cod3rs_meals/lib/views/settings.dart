import 'package:flutter/material.dart';
import 'package:meals/components/side_menu.dart';
import 'package:meals/models/Filters.dart';

class Settings extends StatefulWidget {
  final Filter filter;
  final Function(Filter) onSettingsChange;

  const Settings({Key key, this.onSettingsChange, this.filter})
      : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Filter filters;
  @override
  initState() {
    super.initState();
    filters = widget.filter;
  }

  Widget _createSwitch(
    String title,
    String subTitle,
    bool value,
    Function(bool) action,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: (value) {
        action(value);
        widget.onSettingsChange(filters);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitch('Sem glútem', 'Exibe apenas refeições sem glútem',
                  filters.isGlutenFree, (value) {
                setState(() {
                  filters.isGlutenFree = value;
                });
              }),
              _createSwitch('Sem Lactose', 'Exibe apenas refeições sem Lactose',
                  filters.isLactoseFree, (value) {
                setState(() {
                  filters.isLactoseFree = value;
                });
              }),
              _createSwitch('Comida Vegana', 'Exibe apenas refeições veganas',
                  filters.isVegan, (value) {
                setState(() {
                  filters.isVegan = value;
                });
              }),
              _createSwitch(
                  'Apenas Vegetarianas',
                  'Exibe apenas refeições Vegetarianas',
                  filters.isVegetarian, (value) {
                setState(() {
                  filters.isVegetarian = value;
                });
              }),
            ],
          ))
        ],
      ),
      drawer: SideMenu(),
    );
  }
}
