import 'package:flutter/material.dart';

import 'colors.dart';
import 'model/product.dart';

//Stateless widget- It doesnt change (Does not store mutable state)
class CategoryMenuPage extends StatelessWidget {
  final Category currentCategory; 
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values; //Grabs all possible values from the Category enum so they can be displayed

  const CategoryMenuPage({
    Key? key,
    required this.currentCategory, //The category currently selected
    required this.onCategoryTap, //callback function triggered when a category is tapped 
  }) : super(key: key);

//Builds the UI for each individual categogey item in the list 
//checks if the category is the currently selected one
//if selected, it shows the name in bold 
//adds a line below (highlight)
//if not selected, it shows the name in a faded color
  Widget _buildCategory(Category category, BuildContext context) {
    //converts something like Category.accessories to "ACCESSORIES"
    final categoryString =
        category.toString().replaceAll("Category.", '').toUpperCase();

    final ThemeData theme = Theme.of(context);

//GestureDetector is a widget that detects and respons to user gestures
    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  categoryString,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14.0),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: kShrinePink400,
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                categoryString,
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: kShrineBrown900.withAlpha(153)),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
//Widget's main UI definition 
  @override
  Widget build(BuildContext context) {
    //center the widget on the screen 
    return Center(
      child: Container(
        //adds padding at the top 
        padding: const EdgeInsets.only(top: 40.0),
        //set background color 
        color: kShrinePink100,
        //Displays a scrollable vertical list of categories, built using _buildCategory()
        child: ListView(
          children: _categories
              .map((Category c) => _buildCategory(c, context))
              .toList(),
        ),
      ),
    );
  }
}

