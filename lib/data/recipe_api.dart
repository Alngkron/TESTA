import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testa/models/recipe.dart';

class RecipeApi {
  final String url = "http://localhost:3000";

  List<Recipe> parseRecipe(String responseBody) {
    final parsedData = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsedData
        .map<Recipe>(
          (json) => Recipe.fromJson(json),
        )
        .toList();
  }

  Future<List<Recipe>?> fetchRecipes() async {
    var uri = Uri.parse(url + "/recipes");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return parseRecipe(response.body);
    } else {
      return [];
    }
  }
}
