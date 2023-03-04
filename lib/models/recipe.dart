class Recipe {
  String id;
  String title;
  String description;
  String ingredients;


  Recipe({
    required this.id,
    required this.title,
    this.description,
    this.ingredients,
  });

  static List<Recipe> RecipeList() {
    return [
      Recipe(
        id: '1',
        title: 'milk',
        description: 'add milk',
        imgredients: 'milk and tea',
      ),
     Recipe(
        id: '2',
        title: 'rice',
        description: 'add rice',
        imgredients: 'rice and water',
      ),
    ];
  }
}
