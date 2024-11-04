import 'package:flutter/material.dart';
import 'package:meal/screens/tabs_Screen.dart';

import '../widgets/main_Drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegeterian,
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactosFreeFilter = false;
  bool _veganFilter = false;
  bool _vegetarianFilter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilter,
            Filter.lactoseFree: _lactosFreeFilter,
            Filter.vegan: _veganFilter,
            Filter.vegeterian: _vegetarianFilter
          });
          return false;
        },
        child: Column(children: [
          customSwitch(
            context,
            'Gluten-free',
            'Only include gluten-free meals.',
            _glutenFreeFilter,
            (value) {
              setState(() {
                _glutenFreeFilter = value;
              });
            },
          ),
          customSwitch(
            context,
            'Lactose-free',
            'Only include lactose-free meals.',
            _lactosFreeFilter,
            (value) {
              setState(() {
                _lactosFreeFilter = value;
              });
            },
          ),
          customSwitch(
            context,
            'Vegan',
            'Only include vegan meals.',
            _veganFilter,
            (value) {
              setState(() {
                _veganFilter = value;
              });
            },
          ),
          customSwitch(
            context,
            'Vegetarian',
            'Only include vegetarian meals.',
            _vegetarianFilter,
            (value) {
              setState(() {
                _vegetarianFilter = value;
              });
            },
          ),
        ]),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (String identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }

  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
      value: filter,
      onChanged: onChanged,
    );
  }
}
