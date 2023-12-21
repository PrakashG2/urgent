import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/main.dart';

class MinimizablePlayer extends StatelessWidget {
  const MinimizablePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    //-----------------------------------------------------------------------------------> GETX CONTROLLER INSTANCES
    GlobalController globalGetxController = Get.put(GlobalController());
    MusicDetailsController _musicDetailsController =
        Get.put(MusicDetailsController());

    final audioPlayer = globalGetxController.audioPlayer;
    //-----------------------------------------------------------------------------------> RETURN

    return Obx(() => globalGetxController.isFirstSongPlayed.value
        ? GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.musicPlayerScreen);
            },
            child: Container(
              padding: EdgeInsets.all(7),
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 0, 0, 0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Image(
                  //   // image: NetworkImage(_musicDetailsController
                  //   //     .selectedSongDetails.value.artworkUrl100),
                    
                  //   width: 70,
                  // ),
                  _musicDetailsController
                    .hiResImageSelected.value  != "" ?
                    Image(
                      image: NetworkImage(_musicDetailsController
                        .selectedSongDetails.value.artworkUrl100),
                    
                    width: 70,
                  ) :
                  Image(image: AssetImage("assets/cd.png")),
                  SizedBox(width: 200,child: Text(
                    _musicDetailsController.selectedSongDetails.value.trackName,maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color:  Color.fromARGB(255, 255, 255, 255)),
                  ),),
                  StreamBuilder<SequenceState?>(
                    stream: audioPlayer.sequenceStateStream,
                    builder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<PlayerState>(
                            stream: audioPlayer.playerStateStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final playerState = snapshot.data;
                                final processingState =
                                    playerState!.processingState;

                                if (processingState ==
                                        ProcessingState.loading ||
                                    processingState ==
                                        ProcessingState.buffering) {
                                  return CircularProgressIndicator(
                                    color: Color.fromARGB(255, 151, 144, 144),
                                  );
                                } else if (!audioPlayer.playing) {
                                  return IconButton(
                                    onPressed: audioPlayer.play,
                                    iconSize: 40,
                                    icon: const Icon(
                                      Icons.play_circle,
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (processingState !=
                                    ProcessingState.completed) {
                                  return IconButton(
                                    icon: const Icon(
                                      Icons.pause_circle,
                                      color: Colors.white,
                                    ),
                                    iconSize: 40,
                                    onPressed: audioPlayer.pause,
                                  );
                                } else {
                                  return IconButton(
                                    icon: const Icon(
                                      Icons.replay_circle_filled_outlined,
                                      color: Colors.white,
                                    ),
                                    iconSize: 40,
                                    onPressed: () => audioPlayer.seek(
                                      Duration.zero,
                                      index:
                                          audioPlayer.effectiveIndices!.first,
                                    ),
                                  );
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          StreamBuilder<SequenceState?>(
                            stream: audioPlayer.sequenceStateStream,
                            builder: (context, index) {
                              return IconButton(
                                onPressed: () {
                                  final newPosition = audioPlayer.position +
                                              Duration(seconds: 15) <
                                          audioPlayer.duration!
                                      ? () {
                                          audioPlayer.seek(Duration(
                                              seconds: audioPlayer
                                                      .position.inSeconds +
                                                  15));
                                        }
                                      : null;

                                  if (newPosition != null) {
                                    newPosition();
                                  }
                                },
                                iconSize: 25,
                                icon: const Icon(
                                  CupertinoIcons.goforward_15,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : Container());
  }
}
