import 'dart:convert';
import '../model/food_recipe_module.dart';
import 'package:http/http.dart' as http;

class FoodApiClient {
  Future<FoodRecipe> getFoodRecipe(foodName) async {
    Map<String, String> requestHeaders = {
      'X-RapidAPI-Key': '0155f516cbmsh66bdeb5a6e8b045p19f17bjsn51412ba05bac',
      'X-RapidAPI-Host': 'recipe-by-api-ninjas.p.rapidapi.com'
    };
    var endpointUrl = 'https://recipe-by-api-ninjas.p.rapidapi.com/v1/recipe';

    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'query': foodName,
    });

    final response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      return FoodRecipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load food recipe');
    }
  }
}
