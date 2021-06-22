import 'package:flutter/material.dart';
import 'package:kathai_neram/Web/DashboardPage/DashBoardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  //runApp(KathaiNeram());
  runApp(MaterialApp(
    home: KathaiNeram(),
    debugShowCheckedModeBanner: false,
  ));
}

/*
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
*/
class KathaiNeram extends StatefulWidget {
  @override
  _KathaiNeramState createState() => _KathaiNeramState();
}

class _KathaiNeramState extends State<KathaiNeram> {
  Future<void> getBooks() async {
    Firebase.initializeApp();
    CollectionReference book = FirebaseFirestore.instance.collection('book');
    book
        .get()
        .then((value) => {
          for (var item in value.docs) {
            print(item)
          }

          }).catchError((error) => {print(error)});
    // Call the user's CollectionReference to add a new user
  }

  // @override
  // Widget build(BuildContext context) {
  //   getBooks();
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: DashBoardScreen()
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text("Error");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            getBooks();
            return FutureBuilder(future: getBooks(),
            builder: (context, snapshot) {
              return MaterialApp(
                debugShowCheckedModeBanner: false, home: DashBoardScreen());
            });
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: Text("Loading"));
        });
  }
}
