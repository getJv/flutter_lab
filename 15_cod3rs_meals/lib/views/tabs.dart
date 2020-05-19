import 'package:flutter/material.dart';
import 'package:meals/components/side_menu.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/views/categories.dart';
import 'package:meals/views/favorites.dart';

class Tabs extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const Tabs({Key key, this.favoriteMeals}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedViewIndex = 0;

  List<Map<String, Object>> _views;

  @override
  initState() {
    super.initState();
    _views = [
      {
        'title': 'Vamos Cozinhas',
        'view': Categories(),
      },
      {
        'title': 'Meus favoritos',
        'view': Favorites(
          favoriteMeals: widget.favoriteMeals,
        ),
      },
    ];
  }

  _selectView(int index) {
    setState(() {
      _selectedViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_views[_selectedViewIndex]['title']),
      ),
      body: _views[_selectedViewIndex]['view'],
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedViewIndex,
        type: BottomNavigationBarType.shifting,
        onTap: _selectView,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
              color: Colors.white,
            ),
            title: Text('Categorias'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favoritos'),
          ),
        ],
      ),
    );
  }
}
