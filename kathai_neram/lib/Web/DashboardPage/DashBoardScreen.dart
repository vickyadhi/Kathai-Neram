import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kathai_neram/Web/DashboardPage/pojoModel/DashboardStoryPojo.dart';
import 'package:kathai_neram/Web/Utils/CommonAccess.dart';
import 'package:kathai_neram/Web/Utils/HexColor.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../StoryScreen.dart';

// ignore: must_be_immutable
class DashBoardScreen extends StatefulWidget {
  String docId;

  DashBoardScreen({Key key, @required this.docId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DashBoardScreenState();
  }
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final _scrollController = ScrollController();
  List<DashboardStoryPojo> storiesList = [];
  List<DashboardStoryPojo> storiesSearchList = [];
  int storyVisible = CommonAccess().itemLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    var storyRef = FirebaseFirestore.instance
        .collection('story')
        .where('book', isEqualTo: widget.docId);
    storyRef.get().then((value) {
      setState(() {
        for (var item in value.docs) {
          storiesList.add(DashboardStoryPojo(
              item['title'].toString(),
              item.id.toString(),
              item['audio'].toString(),
              item['story'].toString(),
              item['images']));
        }
        if (storiesList.isNotEmpty) {
          storyVisible = CommonAccess().itemFound;
        } else {
          storyVisible = CommonAccess().itemNotFound;
        }
        //temp added
        storiesSearchList.addAll(storiesList);
       // onStorySearchTextChanged('');
      });
    }).catchError((error) {
      setState(() {
        storyVisible = CommonAccess().itemNotFound;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
          title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Kathai',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  // color:HexColor(CommonAccess().titleBlack1)
                )),
            TextSpan(
                text: ' Neram Stories',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  // color: HexColor(CommonAccess().titleBlack2))
                )),
          ],
        ),
      )),*/
      body: Container(
          /*    decoration: BoxDecoration(
              color: HexColor(CommonAccess().commonBackgroundColor)),*/
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor(CommonAccess().dahBoardBackgroundGradient1),
              HexColor(CommonAccess().dahBoardBackgroundGradient2)
            ]),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor(CommonAccess().dahBoardTopGradient1),
                            HexColor(CommonAccess().dahBoardTopGradient2)
                          ]),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 25,bottom: 25,left: 10,right: 10),
                          child:
                          Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text("Kathai Neram Stories",style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color:Colors.white
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                CommonAccess().appDashboardDesc,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(padding: EdgeInsets.all(10),child:
                        Column(
                          children: [
                            Container(
                                width: 700,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Card(
                                      color:HexColor(CommonAccess().dahBoardSearchBoxColor),
                                      // color: HexColor(new CommonAccess().habitCardColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      elevation: 20,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10, right: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: TextField(
                                                onChanged: onStorySearchTextChanged,
                                                  decoration: new InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder: InputBorder.none,
                                                      enabledBorder: InputBorder.none,
                                                      errorBorder: InputBorder.none,
                                                      disabledBorder:
                                                      InputBorder.none,
                                                      contentPadding:
                                                      EdgeInsets.all(10),
                                                      hintText:
                                                      CommonAccess().searchHint,),
                                              style: TextStyle(fontSize: 25),),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Icon(
                                                    Icons.search,
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            LayoutBuilder(
                              builder:
                                  (BuildContext context, BoxConstraints constraints) {
                                if (storyVisible == CommonAccess().itemNotFound) {
                                  return Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Story Not Found",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ));
                                } else if (storyVisible ==
                                    CommonAccess().itemLoading) {
                                  return Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.black45),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: Text(
                                              'Loading Story..',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ));
                                } else if (storyVisible == CommonAccess().itemFound) {
                                  return Container(
                                    height: CommonAccess().storyCardHeight,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: storiesSearchList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoryScreen(
                                                              story: storiesSearchList[index])),
                                                );
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Card(
                                                    color:HexColor(CommonAccess().dahBoardStoryCardColor),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                      ),
                                                      elevation: 10,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    storiesSearchList[index]
                                                                        .images[0]),
                                                                fit: BoxFit.fill)),
                                                        width: CommonAccess()
                                                            .storyCardWidth,
                                                        height: CommonAccess()
                                                            .storyImageHeight,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Card(
                                                        color:HexColor(CommonAccess().dahBoardStoryCardColor),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                        ),
                                                        elevation: 10,
                                                        child: SizedBox(
                                                            height: CommonAccess()
                                                                .storyTextHeight,
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                              child: Expanded(
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.center,
                                                                    child: Text(
                                                                      storiesSearchList[index]
                                                                          .title,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontSize: 15,
                                                                          color: Colors
                                                                              .black),
                                                                    ),
                                                                  )),
                                                            ))),
                                                  ],
                                                ),
                                                width: CommonAccess().storyCardWidth,
                                              ));
                                        }),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),),
                    ],
                  ),
                )),
          )),
    );
  }

  getItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoryScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Image.network(doc["thumbnail"]),
                Text(doc["title"],
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.visible)
              ]),
              color: Colors.blueGrey,
            )))
        .toList();
  }

  onStorySearchTextChanged(String text) async {
    storiesSearchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    storiesList.forEach((storyDetail) {
      if (storyDetail.title.contains(text)){
        storiesSearchList.add(storyDetail);
      }
    });
    setState(() {});
  }
}
