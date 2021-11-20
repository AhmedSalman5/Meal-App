import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = 'category_meal';
  final List<Meal> availableMeals;

    CategoriesMealScreen(this.availableMeals);
  @override
  _CategoriesMealScreenState createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {

String categoryTitle;
List<Meal> displayedMeals;
@override
  void didChangeDependencies() {
  final routeArg =ModalRoute.of(context).settings.arguments as Map <String,String>;
  final categoryId = routeArg['id'];
  categoryTitle = routeArg['title'];
  displayedMeals = widget.availableMeals.where((meal) {
    return meal.categories.contains(categoryId);
  }).toList();
    super.didChangeDependencies();
  }



  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle),),
      body: ListView.builder(
          itemBuilder: (ctx,index){
            return MealItem(
                id: displayedMeals[index].id,
                imageUrl: displayedMeals[index].imageUrl,
                title: displayedMeals[index].title,
                duration: displayedMeals[index].duration,
                complexity: displayedMeals[index].complexity,
                affordability: displayedMeals[index].affordability,


            );
          },
          itemCount: displayedMeals.length,
      ),
    );
  }
}
