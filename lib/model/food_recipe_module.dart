class FoodRecipe {
  final String ingredients;
  final String instructions;

  const FoodRecipe({required this.ingredients, required this.instructions});

  factory FoodRecipe.fromJson(List<dynamic> json) {
    return FoodRecipe(
      ingredients: json[0]['ingredients'] ?? "",
      instructions: json[0]['instructions'] ?? "",
    );
  }
}
