// Create a Form widget.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewStoryScreen extends StatefulWidget {
  @override
  _AddNewStoryScreenState createState() => _AddNewStoryScreenState();
}

class _AddNewStoryScreenState extends State<AddNewStoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> data = {"book": "CgETAiAV11kMAZPyG8VL"};

  void _submit() {
    if (_formKey.currentState.validate()) {
      FirebaseFirestore.instance
          .collection("story")
          .doc()
          .set(data)
          .whenComplete(() => {_formKey.currentState.reset()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
            LinearGradient(colors: [Colors.red[200], Colors.orange[200]]),
          ),
        ),
        title: Text("Add New Story"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: "CgETAiAV11kMAZPyG8VL",
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Book ID'),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter title!';
                      } else {
                        data["title"] = value;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Story'),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter story!';
                      } else {
                        data["story"] = value;
                      }
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Story Thumbnail Public URL'),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Audio URL!';
                        } else {
                          data["thumbnail"] = value;
                        }
                      }),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Image Public URLs(Seperated by ,)'),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter story!';
                      } else {
                        data["images"] = value.replaceAll(" ", "").split(",");
                      }
                    },
                  ),
                  TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Audio Public URL'),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Audio URL!';
                        } else {
                          data["audio"] = value;
                        }
                      }),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[200], // background
                    ),
                    onPressed: _submit,
                    child: Text("submit"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
