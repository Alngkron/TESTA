import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testa/data/recipe_api.dart';
import 'package:testa/models/recipe.dart';
// import 'package:testa/data/recipe_data.dart';
import 'package:testa/pages/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    recipes = await RecipeApi().fetchRecipes() ?? [];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text('Food Recipes'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  title: recipes[index].name,
                  rating: recipes[index].rating.toString(),
                  cookTime: recipes[index].totalTime,
                  thumbnailUrl: recipes[index].images,
                );
              },
            ),
    );
  }
}
