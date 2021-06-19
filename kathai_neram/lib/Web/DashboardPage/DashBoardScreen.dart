import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kathai_neram/Web/Utils/CommonAccess.dart';
import 'package:kathai_neram/Web/Utils/HexColor.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DashBoardScreenState();
  }
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final _scrollController = ScrollController();
  List<Category> getCategories1 = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Category category = new Category();
    category.name = "test";
    category.image = "https://picsum.photos/400/300";
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
    getCategories1.add(category);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                            itemCount: 15,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(child: Card(
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
                                                  "https://blog-cdn.reedsy.com/uploads/2019/04/andy-catling-2.jpg"),
                                              fit: BoxFit.fill)),
                                      width: CommonAccess().storyCardWidth,
                                      height: CommonAccess().storyImageHeight,
                                    ),
                                    SizedBox(height: CommonAccess().storyTextHeight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5,right: 5),
                                        child: Expanded(
                                            child:  Align(alignment: Alignment.center,
                                              child: Text("ஒன்றுக்கு ஒன்று!",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),)
                                        ),
                                      ))
                                  ],
                                ),
                              ),width: CommonAccess().storyCardWidth,);
                            }),
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}

class Category {
  String name;
  String image;

  Category({
    this.name,
    this.image,
  });
}
