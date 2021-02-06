import 'dart:io';

import 'package:diy_recipe/widgets/recipe_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeFormField {
  final int index;
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController unitController;

  const RecipeFormField(
      {this.index = 0,
      this.titleController,
      this.amountController,
      this.unitController});
}

class RecipeFormPage extends StatefulWidget {
  static const String baseRoute = '/recipe_form';

  @override
  _RecipeFormPage createState() => _RecipeFormPage();
}

class _RecipeFormPage extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  PickedFile _image;

  final picker = ImagePicker();

  List<RecipeFormField> _fields = [
    RecipeFormField(
        index: 0,
        titleController: TextEditingController(),
        amountController: TextEditingController(),
        unitController: TextEditingController())
  ];

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = new PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = new PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (buildCotext) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () async {
                    getImageFromGallery();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () async {
                    getImageFromCamera();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Recipe"),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      _image == null
                          ? Text("Choose Image")
                          : Image.file(
                              File(_image.path),
                              height: 200,
                            ),
                      ElevatedButton(
                          onPressed: () {
                            _showPicker(context);
                          },
                          child: Text("Upload")),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name Recipe",
                            filled: true,
                            hintText: "Name Recipe"),
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter name here.";
                          }
                          return null;
                        },
                      ),
                      for (final field in _fields)
                        RecipeTextField(
                            field: field,
                            onRemove: (int position) {
                              setState(() {
                                _fields.removeAt(position);
                                print(_fields.length);
                              });
                            }),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _fields.add(RecipeFormField(
                                  index: _fields.length - 1,
                                  titleController: TextEditingController(),
                                  amountController: TextEditingController(),
                                  unitController: TextEditingController()));
                            });
                            print(_fields.length);
                          },
                          child: Text("Add")),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print(_nameController.text);
                              _fields.forEach((element) {
                                print("${element.titleController.text}"
                                    "${element.amountController.text}"
                                    "${element.unitController.text}");
                              });
                            }
                          },
                          child: Text("Submit")),
                    ],
                  ),
                ))));
  }
}
