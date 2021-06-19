import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(KathaiNeram());
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference book = FirebaseFirestore.instance.collection('book');

    Future<void> addUser() {
      book.get().then((value) => print(value));
      // Call the user's CollectionReference to add a new user
      return book
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class KathaiNeram extends StatefulWidget {
  @override
  _KathaiNeramState createState() => _KathaiNeramState();
}

class _KathaiNeramState extends State<KathaiNeram> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kathai"),
        ),
        body: Row(
          children: [],
        ),
      ),
    );
  }
}
