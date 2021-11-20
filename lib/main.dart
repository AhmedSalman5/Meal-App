import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data%20(1).dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool>_filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal>_availableMeals = DUMMY_MEALS;
  List<Meal>_favoriteMeals = [];

void _setFilters (Map<String,bool>_filterDate){
  setState(() {
    _filters = _filterDate;

    _availableMeals = DUMMY_MEALS.where((meal) {
       if(_filters['gluten'] && meal.isGlutenFree){
         return false;
       }
       if(_filters['lactose'] && meal.isLactoseFree){
         return false;
       }
       if(_filters['vegetarian'] && meal.isVegetarian){
         return false;
       }
       if(_filters['vegan'] && meal.isVegan){
         return false;
       }
       return true;
    }).toList();
  });
}

void _toggleFavorite(String mealId){
 final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

 if(existingIndex >= 0){
   setState(() {
     _favoriteMeals.removeAt(existingIndex);
   });
 }
 else{
   setState(() {
     _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
   });
 }

}

bool _isMealFavorite(String id){
  return _favoriteMeals.any((meal) => meal.id == id);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          body2: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
          ),
          title: TextStyle(
            fontSize: 21,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
     // home: MyHomePage(),
      routes: {
        '/': (context)=> TabsScreen(_favoriteMeals),
        CategoriesMealScreen.routeName:(context)=> CategoriesMealScreen(_availableMeals),
        MealDetailScreen.routeName:(context)=> MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routName:(context)=> FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null,
    );
  }
}
