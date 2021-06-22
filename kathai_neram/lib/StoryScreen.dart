import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'Web/DashboardPage/pojoModel/DashboardStoryPojo.dart';

class StoryScreen extends StatefulWidget {
  final DashboardStoryPojo story;
  const StoryScreen({Key key, this.story}) : super(key: key);
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final player = AudioPlayer();
 IconButton playButton;
 IconButton pauseButton;
bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    playButton = IconButton(
                onPressed: () {
                  playAudio();
                  setState(() {
                    isPlaying = true;
                  });
                },
                icon: Icon(Icons.send));
  pauseButton = IconButton(
                onPressed: () {
                  player.pause();
                  setState(() {
                    isPlaying = false;
                  });
                },
                icon: Icon(Icons.pause));

    var splits = widget.story.story.split("{image}");
    
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Story Screen"),
          actions: [ isPlaying ? pauseButton : playButton
          ],
        ),
        body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: splits.length,
            itemBuilder: (BuildContext context, int index) {
              return itemForIndex(index, splits);
            }));
  }

  playAudio() async {
    var duration = await player.setUrl(
        widget.story.audio);
    print(duration);
    player.play();
  }

  itemForIndex(int index, List<String> splits) {
    List<Widget> list =  [
          Align(
              alignment: Alignment.bottomRight,
              child: Image.network(widget.story.images[index], width: 500,)),
          Flexible(
            child: Text(splits[index],
              textAlign: TextAlign.justify,
              maxLines: 12,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
            ),
          ),
        ];

    if (index % 2 == 0) {
      return Row(
        children:list,
      );
    } else {
      return Row(
        children: list.reversed.toList()
      );
    }
  }
}
