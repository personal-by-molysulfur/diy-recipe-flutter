import 'package:diy_recipe/pages/recipe_form.dart';
import 'package:flutter/material.dart';

class RecipeTextField extends StatefulWidget {
  final String title = "Title";
  final String amount = "Amount";
  final String unit = "Unit";
  final RecipeFormField field;

  final Function(int) onRemove;

  const RecipeTextField({this.field, this.onRemove});

  @override
  _RecipeTextField createState() => _RecipeTextField();
}

class _RecipeTextField extends State<RecipeTextField> {
  final sizedBoxSpace = SizedBox(height: 24);

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: widget.title,
                    filled: true,
                    hintText: widget.title),
                controller: widget.field.titleController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter name here.";
                  }
                  return null;
                },
              )),
          Flexible(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: widget.amount,
                    filled: true,
                    hintText: widget.amount),
                controller: widget.field.amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter name here.";
                  }
                  return null;
                },
              )),
          Flexible(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: widget.unit,
                    filled: true,
                    hintText: widget.unit),
                controller: widget.field.unitController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter name here.";
                  }
                  return null;
                },
              )),
          Flexible(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.onRemove(widget.field.index);
              },
            ),
          )
        ],
      ),
    ));
  }
}
