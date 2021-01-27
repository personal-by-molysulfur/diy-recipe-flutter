import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeFormPage extends StatefulWidget {
  static const String baseRoute = '/recipe_form';

  @override
  _RecipeFormPage createState() => _RecipeFormPage();
}

class _RecipeFormPage extends State<RecipeFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Recipe"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Recipe Form Pages',
              )
            ],
          ),
        ));
  }
}
