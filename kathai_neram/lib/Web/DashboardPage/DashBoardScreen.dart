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
            child:   Padding(
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
                                color: HexColor(CommonAccess().titleBlack1))),
                        TextSpan(
                            text: ' Neram',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: HexColor(CommonAccess().titleBlack2))),
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
                  Container(width: 700,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Card(
                            color: Colors.white,
                            // color: HexColor(new CommonAccess().habitCardColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: TextField( decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.all(10),
                                        hintText: CommonAccess().searchHint)),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Align(alignment: Alignment.centerRight,child: Icon(Icons.search,size: 25,color: Colors.black,),)
                                  )
                                ],
                              ),
                            )),
                      )),
                  SizedBox(height: 15,),
                /*  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context,index){
                      return Text("data");
                    },itemCount: 100,),*/
                  GridView.builder(
                    itemCount:15,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape ? 3: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: (2 / 1),
                    ),
                    itemBuilder: (context,index,) {
                      return GestureDetector(
                        onTap:(){
                        },
                        child:Container(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add),
                              Text('items[index]',style: TextStyle(fontSize: 18, color: Colors.black),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )),)),);
  }
}
