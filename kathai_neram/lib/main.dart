import 'package:flutter/material.dart';
import 'package:kathai_neram/Web/DashboardPage/DashBoardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  // runApp(KathaiNeram());
  runApp(MaterialApp(
    home: KathaiNeram(),
    debugShowCheckedModeBanner: false,
  ));
}

class Book {
  final List<String> stories;
  final String thumbnail;
  final String title;

  Book({this.stories, this.thumbnail, this.title});
  
}

class KathaiNeram extends StatefulWidget {
  @override
  _KathaiNeramState createState() => _KathaiNeramState();
}

class _KathaiNeramState extends State<KathaiNeram> {
  /*
  Future<List<Book>> getBooks() async {
    Firebase.initializeApp();
    CollectionReference book = FirebaseFirestore.instance.collection('book');
    book
        .get()
        .then((value) =>  {
          for (var item in value.docs) {
            print(item.data())
          }
          
                      
          }).catchError((error) => {print(error)});
    // Call the user's CollectionReference to add a new user
  }
*/
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
            return BookGridScreen();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Text("Loading");
        });
  }
}

class BookGridScreen extends StatefulWidget {  
  BookGridScreen({Key key}) : super(key: key);  
  @override  
  _BookGridScreenState createState() => _BookGridScreenState();  
}  
  
class _BookGridScreenState extends State<BookGridScreen> {  
  @override  
  Widget build(BuildContext context) { 
      
    return Scaffold(  
      appBar: AppBar(title: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Kathai Neram Books' ,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    // color:HexColor(CommonAccess().titleBlack1)
                                    )),
                          ],
                        ),
                      )),  
      body: Center(  
          child: StreamBuilder<QuerySnapshot> ( stream: FirebaseFirestore.instance.collection("book").snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no Book");
          return GridView.extent(  
            primary: false,  
            padding: const EdgeInsets.all(16),  
            crossAxisSpacing: 10,  
            mainAxisSpacing: 10,  
            maxCrossAxisExtent: 200.0,  
            children: getItems(snapshot),  
          );
        }))   
    );  
  }  

  getItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) =>
        TextButton(onPressed: () {
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DashBoardScreen(docId: doc.id)),
  );
        }
        , child: Container(  
                padding: EdgeInsets.all(8),  
                child: Column(children: [
                  Image.network(doc["thumbnail"]),
                  Text(doc["title"], style: TextStyle(fontSize: 20), overflow: TextOverflow.visible)]),  
                color: Colors.blueGrey,  
              ))
          
              )
        .toList();
        
  }
 
}  
