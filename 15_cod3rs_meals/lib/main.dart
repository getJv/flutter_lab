import 'package:flutter/material.dart';
import 'package:meals/models/Filters.dart';
import 'package:meals/utils/app_routes.dart';
import 'package:meals/views/Settings.dart';
import 'package:meals/views/category_meals.dart';
import 'package:meals/views/favorites.dart';
import 'package:meals/views/meal_details.dart';
import 'package:meals/views/tabs.dart';

import 'data/dummy_data.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  Filter filter = Filter();

  void _filterMeals(Filter filter) {
    setState(() {
      this.filter = filter;
      _avaliableMeals = DUMMY_MEALS.where((meal) {
        final filterGlutem = !meal.isGlutenFree && filter.isGlutenFree;
        final filterLactose = !meal.isLactoseFree && filter.isLactoseFree;
        final filterVegun = !meal.isVegetarian && filter.isVegan;
        final filterVegetarian = !meal.isVegetarian && filter.isVegetarian;
        return !filterGlutem &&
            !filterLactose &&
            !filterVegun &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway,',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => Tabs(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORY_MEALS: (ctx) => CategoryMeals(
              meals: _avaliableMeals,
            ),
        AppRoutes.MEAL_DETAILS: (ctx) =>
            MealDetails(action: _toggleFavorite, isFavorite: _isFavorite),
        AppRoutes.FAVORITES: (ctx) => Favorites(),
        AppRoutes.SETTINGS: (ctx) => Settings(
            filter: filter,
            onSettingsChange: (filter) {
              _filterMeals(filter);
            }),
      },
    );
  }
}
