import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'Web/DashboardPage/pojoModel/DashboardStoryPojo.dart';
import 'audio.dart';

double deviceSize(BuildContext context) => MediaQuery.of(context).size.width;

class StoryScreen extends StatefulWidget {
  final DashboardStoryPojo story;

  const StoryScreen({Key key, this.story}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration _duration;
  AudioPlayer _audioPlayer;
  IconButton playButton;
  IconButton pauseButton;
  double textSize = 30;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlayerOpened = false;
    playButton = IconButton(
        onPressed: () {
          playAudio();
          setState(() {
            isPlaying = true;
          });
        },
        icon: Icon(Icons.play_arrow));
    pauseButton = IconButton(
        onPressed: () {
          player.pause();
          setState(() {
            isPlaying = false;
          });
        },
        icon: Icon(Icons.pause));

    var splits = widget.story.story.split("{image}");
    splits.removeWhere((element) => element.length < 1);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 90,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal, Colors.lightGreenAccent]),
            ),
          ),
          title: Text("Story Screen"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.font_download_outlined),
            ),
            Slider(
                value: textSize,
                min: 20,
                max: 50,
                divisions: 5,
                label: textSize.round().toString(),
                onChanged: (currentValue) {
                  setState(() {
                    textSize = currentValue;
                  });
                }),
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: splits.length,
              itemBuilder: (BuildContext context, int index) {
                return itemForIndex(index, splits);
              }),
        ),
        floatingActionButton: floatingActionItem,
      ),
    );
  }


  playAudio() async {
    var duration = await player.setUrl(widget.story.audio);
    print(duration);
    player.play();
  }

  itemForIndex(int index, List<String> splits) {
    /* if (index % 2 == 0) {
      return Row(
        children: list,
      );
    } else {
      return Row(children: list.reversed.toList());
    }*/
    if (isMobile(context)) {
      return Column(
        children: [
          Image.network(
            widget.story.images[index],
            // width: 500,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              splits[index],
              textAlign: TextAlign.justify,
              //style: TextStyle(fontSize: 15),
              style: TextStyle(fontSize: textSize),
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
            ),
          ),
          Expanded(child: Text(widget.story.title[index]))
        ],
      );
    } else {
      List<Widget> list = [
        /*Align(
          alignment: Alignment.bottomRight,
          child: Image.network(
            widget.story.images[index],
            width: 500,
          )),
      Flexible(
        child: Text(
          splits[index],
          textAlign: TextAlign.justify,
          maxLines: 12,
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.visible,
        ),
      ),*/
        Expanded(
          flex: 1,
          child: Image.network(
            widget.story.images[index],
            // width: 500,
          ),
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                splits[index],
                textAlign: TextAlign.justify,
                //style: TextStyle(fontSize: 30),
                style: TextStyle(fontSize: textSize),
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.visible,
              ),
            ))
      ];
      if (index % 2 == 0) {
        return Row(
          children: list,
        );
      } else {
        return Row(children: list.reversed.toList());
      }
    }
  }
  onPaused() {
    setState(() {
      isPlaying= false;
    });
  }
  get floatingActionItem {
    Widget floatingPlayer = FloatingAudioPlayer(onPaused: onPaused,audioUrl: widget.story.audio,);

   /* Widget floatingPlayer = GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 35,),
          Container(
            height: 125,
            width: 325,
            color: Colors.teal,
          ),
        ],
      ),
      onTap: () {
        setState(() {
          isPlaying = false;
        });
      },
    );*/

    Widget floatingActionButton = FloatingActionButton(
      onPressed: () {
        setState(() {
          isPlaying = true;
        });
      },
      child: Icon(Icons.play_arrow_outlined),
    );

    return AnimatedSwitcher(
      reverseDuration: Duration(milliseconds: 0),
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
     // child: isPlaying ? pauseButton : playButton,
      child: isPlaying ? floatingPlayer: floatingActionButton,

    );
  }

}

