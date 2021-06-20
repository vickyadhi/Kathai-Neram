import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kathai_neram/Web/DashboardPage/pojoModel/DashboardStoryPojo.dart';
import 'package:kathai_neram/Web/Utils/CommonAccess.dart';
import 'package:kathai_neram/Web/Utils/HexColor.dart';
import 'package:firebase_core/firebase_core.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DashBoardScreenState();
  }
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final _scrollController = ScrollController();
  List<DashboardStoryPojo> storyArray = [];
  int storyVisible=CommonAccess().itemLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    CollectionReference storyList =
        FirebaseFirestore.instance.collection('storyList');
    storyList.get().then((value) {
      setState(() {
        for (var item in value.docs) {
          storyArray.add(DashboardStoryPojo(item['story_title'].toString(),
              item['story_image'].toString(), item['story_title'].toString()));
        }
        if(storyArray.isNotEmpty){
          storyVisible=CommonAccess().itemFound;
        }else{
          storyVisible=CommonAccess().itemNotFound;
        }
      });
    }).catchError((error){
      setState(() {
        storyVisible=CommonAccess().itemNotFound;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: HexColor(CommonAccess().commonBackgroundColor)),
          width: double.infinity,
          height: double.infinity,
          child: Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Kathai',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        HexColor(CommonAccess().titleBlack1))),
                            TextSpan(
                                text: ' Neram',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        HexColor(CommonAccess().titleBlack2))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        CommonAccess().appDashboardDesc,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 700,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Card(
                                color: Colors.white,
                                // color: HexColor(new CommonAccess().habitCardColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
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
                                                    CommonAccess().searchHint)),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.search,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                          ))
                                    ],
                                  ),
                                )),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: CommonAccess().storyCardHeight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: storyArray.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    storyArray[index].storyImage
                                                ),
                                                fit: BoxFit.fill)),
                                        width: CommonAccess().storyCardWidth,
                                        height: CommonAccess().storyImageHeight,
                                      ),
                                      SizedBox(
                                          height:
                                          CommonAccess().storyTextHeight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    storyArray[index].storyName,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                )),
                                          ))
                                    ],
                                  ),
                                ),
                                width: CommonAccess().storyCardWidth,
                              );
                            }),
                      )
/*                      Builder(builder: (context){
                        if(storyVisible==CommonAccess().itemFound){
                          return
                            Container(
                            height: CommonAccess().storyCardHeight,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: storyArray.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        storyArray[index].storyImage
                                                    ),
                                                    fit: BoxFit.fill)),
                                            width: CommonAccess().storyCardWidth,
                                            height: CommonAccess().storyImageHeight,
                                          ),
                                          SizedBox(
                                              height:
                                              CommonAccess().storyTextHeight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Expanded(
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        storyArray[index].storyName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                            color: Colors.black),
                                                      ),
                                                    )),
                                              ))
                                        ],
                                      ),
                                    ),
                                    width: CommonAccess().storyCardWidth,
                                  );
                                }),
                          );
                        }else  if(storyVisible==CommonAccess().itemNotFound){
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
                        }else{
                          return Expanded(child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black45),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'Please Story..',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              )
                            ],
                          ));
                        }
                      },)*/
                    ],
                  ),
                )),
          )),
    );
  }
}
