import 'package:flutter/material.dart';
import 'package:sample_project/constants/colors.dart';
import '../models/recipe.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({
    super.key,
    required this.recipe,
    required this.onChangeItem,
    required this.onDeleteItem,
  });

  final Recipe recipe;
  final onChangeItem;
  final onDeleteItem;

//View all recipe items in the app body
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: () {
          onChangeItem(recipe);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          recipe.title,
          style: const TextStyle(
            color: textWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
         title: Text(
          recipe.description,
          style: const TextStyle(
            color: textWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
         title: Text(
          recipe.ingredients,
          style: const TextStyle(
            color: textWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          child: IconButton(
            color: textWhite,
            icon: const Icon(
              Icons.delete,
              size: 20.0,
            ),
            onPressed: () {
              onDeleteItem(recipe.id);
            },
          ),
        ),
          trailing: Container(
          child: IconButton(
            color: textWhite,
            icon: const Icon(
              Icons.update,
              size: 20.0,
            ),
            onPressed: () {
              onChangeItem(recipe.id);
            },
          ),
        ),
      ),
    );
  }
}
