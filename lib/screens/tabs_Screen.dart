import 'package:flutter/material.dart';
import 'package:meal/screens/categories_Screen.dart';
import 'package:meal/screens/meals_Screen.dart';

import '../models/meal.dart';
import '../widgets/main_Drawer.dart';
import 'favorite_Screen.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Meal> _favoriteMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMessage("removed");
    } else {
      setState(() {
        _favoriteMeal.add(meal);
      });
      _showInfoMessage("added");
    }
  }

  Map<Filter, bool> _selectedFilters = kInitialFilter;

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );

    var activePageTitle = 'Pick your category';

    if (_selectedIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Cateories"),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const FiltersScreen(),
              ),
            ).then(
              (value) =>
                  setState(() => _selectedFilters = value ?? kInitialFilter),
            );
          }
        },
      ),
    );
  }
}
