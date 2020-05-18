import 'package:flutter/material.dart';
import 'package:meals/utils/app_routes.dart';
import 'package:meals/views/category_meals.dart';
import 'package:meals/views/favorites.dart';
import 'package:meals/views/meal_details.dart';
import 'package:meals/views/tabs.dart';
import 'views/categories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        AppRoutes.HOME: (ctx) => Tabs(),
        AppRoutes.CATEGORY_MEALS: (ctx) => CategoryMeals(),
        AppRoutes.MEAL_DETAILS: (ctx) => MealDetails(),
        AppRoutes.FAVORITES: (ctx) => Favorites(),
      },
    );
  }
}
