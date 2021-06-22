import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class StoryScreen extends StatefulWidget {
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
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return itemForIndex(index);
            }));
  }

  playAudio() async {
    var duration = await player.setUrl(
        'https://firebasestorage.googleapis.com/v0/b/kathaineram-d1d7f.appspot.com/o/Tamil%20audio.mp3?alt=media&token=082eba78-0092-4c1d-9091-c953bb826f9c');
    print(duration);
    player.play();
  }

  itemForIndex(int index) {
    if (index % 2 == 0) {
      return Row(
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Image.network(
                  'https://gumlet.assettype.com/vikatan%2F2019-06%2Fd3ff9ffa-eea6-4acd-9a35-3d92b8d5e3e0%2F48_1560507036.jpg?auto=format%2Ccompress&format=webp&w=640&dpr=1.4')),
          Flexible(
            child: Text(
              'அந்தக் காட்டுக்குள் வேட்டைக்காரன் ஒருவன், தான் வைத்த பொறியில் தெரியாமல் தன் கால்களை வைத்துவிட்டு துடித்துக் கொண்டிருந்தான். அதைப் பார்த்த ஒரு மரவெட்டி,'
              'நீ வேட்டையாடும் விலங்குகளும் இப்படித்தானே துடிக்கும் என்றபடி விடுவித்தான்.'
              'நீ மட்டும் மரங்களை வெட்டுகிறாயே. அவற்றுக்கும்தானே உயிர் இருக்கிறது'
              ' என்றான் வேட்டைக்காரன்.'
              'நான் பட்டுப்போன மரங்களை மட்டுமே வெட்டுகிறேன். நீ எப்படி... இறந்த விலங்குகளையே வேட்டையாடுகிறாயா?'
              'அமைதியாக இருந்த வேட்டைக்காரன், நாளை முதல் நானும் உன்னுடன் மரம் வெட்ட வருகிறேன் என்றான். அதைக் கேட்டு காடு மகிழ்வது போல காற்று அடித்தது.',
              textAlign: TextAlign.justify,
              maxLines: 12,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Flexible(
            child: Text(
              'அந்தக் காட்டுக்குள் வேட்டைக்காரன் ஒருவன், தான் வைத்த பொறியில் தெரியாமல் தன் கால்களை வைத்துவிட்டு துடித்துக் கொண்டிருந்தான். அதைப் பார்த்த ஒரு மரவெட்டி,'
              'நீ வேட்டையாடும் விலங்குகளும் இப்படித்தானே துடிக்கும் என்றபடி விடுவித்தான்.'
              'நீ மட்டும் மரங்களை வெட்டுகிறாயே. அவற்றுக்கும்தானே உயிர் இருக்கிறது'
              ' என்றான் வேட்டைக்காரன்.'
              'நான் பட்டுப்போன மரங்களை மட்டுமே வெட்டுகிறேன். நீ எப்படி... இறந்த விலங்குகளையே வேட்டையாடுகிறாயா?'
              'அமைதியாக இருந்த வேட்டைக்காரன், நாளை முதல் நானும் உன்னுடன் மரம் வெட்ட வருகிறேன் என்றான். அதைக் கேட்டு காடு மகிழ்வது போல காற்று அடித்தது.',
              textAlign: TextAlign.justify,
              maxLines: 12,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.network(
                  'https://gumlet.assettype.com/vikatan%2F2019-06%2Fd3ff9ffa-eea6-4acd-9a35-3d92b8d5e3e0%2F48_1560507036.jpg?auto=format%2Ccompress&format=webp&w=640&dpr=1.4')),
        ],
      );
    }
  }
}
