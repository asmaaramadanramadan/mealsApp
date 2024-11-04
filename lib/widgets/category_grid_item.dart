import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../screens/meals_Screen.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onToggleFavorite,
    // required this.availableMeals,
  });

  final Category category;
  final void Function(Meal meal) onToggleFavorite;
  //final List<Meal> availableMeals;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final List<Meal> filteredMeal = dummyMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeal,
              onToggleFavorite: onToggleFavorite,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.54),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
