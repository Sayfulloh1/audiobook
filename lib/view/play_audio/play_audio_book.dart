import 'package:audiobook/constants/common_functions.dart';
import 'package:audiobook/utils/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../utils/local_audio_sources.dart';

class PlayAudioBookScreen extends StatefulWidget {
  PlayAudioBookScreen({required this.index});

  int index;


  @override
  State<PlayAudioBookScreen> createState() => _PlayAudioBookScreenState();
}

class _PlayAudioBookScreenState extends State<PlayAudioBookScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isRepeated = true;

  void repeatAudio(){
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }
  void releaseAudio(){
    audioPlayer.setReleaseMode(ReleaseMode.release);
  }

  @override
  void initState() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: orange,
        appBar: PreferredSize(
          preferredSize: Size(width, height * .1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 40,
                  color: white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 40,
                  color: white,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * .5,
                height: width * .5,
                child: Image.asset('assets/images/book.png'),
              ),
              CommonFunctions.blankSpace(height * .1, 0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                      await audioPlayer.pause();
                    },
                    activeColor: white,
                    inactiveColor: grey,
                  ),
                  Container(
                    width: width * .88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(position)),
                        Text(formatTime(duration - position)),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isRepeated = !isRepeated;
                        });
                        isRepeated?releaseAudio():repeatAudio();
                      },
                      icon: Icon(
                        Icons.repeat_one,
                        color: isRepeated?Colors.white:Colors.grey,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.index > 0) {
                            widget.index--;
                          } else {
                            widget.index = books.length - 1;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.skip_previous_sharp,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          String url = book_locations[widget.index];
                          await audioPlayer.play(AssetSource(url));
                        }
                      },
                      icon: Icon(
                        isPlaying
                            ? Icons.pause
                            : Icons.play_circle_fill_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.index + 1 < books.length) {
                            widget.index++;
                          } else {
                            widget.index = 0;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.skip_next_sharp,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.queue_music,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
