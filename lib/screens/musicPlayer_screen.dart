import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';

import 'package:rxdart/rxdart.dart' as rxdart;

class musicPlayerScreen extends StatefulWidget {
  const musicPlayerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<musicPlayerScreen> createState() => _musicPlayerScreenState();
}

class _musicPlayerScreenState extends State<musicPlayerScreen> {
  // AudioPlayer audioPlayer = AudioPlayer();

  MusicDetailsController _musicDetailsController = Get.put(MusicDetailsController());
    GlobalController globalGetxController = Get.put(GlobalController());


 @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Check if the selected song is different from the currently playing song
    if (_musicDetailsController.selectedSongDetails.value.url !=
        globalGetxController.currentPlayingUrl.value) {
      globalGetxController.initializeAudioPlayer();

      globalGetxController.isFirstSongPlayed.value = true;
    }
  });
}

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          globalGetxController.audioPlayer.positionStream,
          globalGetxController.audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });
  @override
  Widget build(BuildContext context) {
    if (_musicDetailsController.isLoading.value) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Obx(
          () => Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: NetworkImage(_musicDetailsController
                    .hiResImageSelected.value),
                fit: BoxFit.cover,
              ),
              _BackgroundFilterBlur(),
              _BackgroundFilter(),
              Positioned(
                top: 50,
                left: 10,
                right: 10,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 75, 74, 74)
                              .withOpacity(0.70), // Set the shadow color
                          spreadRadius: 9,
                          blurRadius: 25,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _musicDetailsController
                    .hiResImageSelected.value  != "" ?
                    Image(
                      image: NetworkImage(_musicDetailsController
                        .hiResImageSelected.value),
                    
                    width: 70,
                  ) :
                  Image(image: AssetImage("assets/cd.png"),fit: BoxFit.fitHeight,),
                    ),
                  ),
                ),
              ),
              _MusicPlayer(
                seekBarDataStream: _seekBarDataStream,
                audioPlayer: globalGetxController.audioPlayer,
                trackName:
                 _musicDetailsController.selectedSongDetails.value.trackName,
                composoerDetails: _musicDetailsController
                    .selectedSongDetails.value.artistName,
                movieName: _musicDetailsController
                    .selectedSongDetails.value.collectionName,
              ),
              // if(globalGetxController.isExpanded.value)Positioned(
              //   bottom: 400,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     height: 100,
              //     child: MinimizablePlayer(audioPlayer: audioPlayer)
              //   ),
              // )
            ],
          ),
        ));
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer({
    Key? key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.trackName,
    required this.composoerDetails,
    required this.movieName,
  })  : _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final String trackName;
  final String composoerDetails;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 15.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 150,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName.toUpperCase(),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Color.fromARGB(255, 12, 9, 9),
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    trackName,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          composoerDetails,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<SeekBarData>(
                    stream: _seekBarDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        position: positionData?.position ?? Duration.zero,
                        duration: positionData?.duration ?? Duration.zero,
                        onChangeEnd: audioPlayer.seek,
                      );
                    },
                  ),
                ],
              )),
          const SizedBox(height: 30),
          PlayerButtons(audioPlayer: audioPlayer),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
            ],
            stops: const [
              0.1,
              0.4
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(47, 0, 0, 0),
              Color.fromARGB(55, 0, 0, 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundFilterBlur extends StatelessWidget {
  const _BackgroundFilterBlur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: () {
                final newPosition =
                    audioPlayer.position - Duration(seconds: 15);
                if (newPosition > Duration.zero) {
                  audioPlayer.seek(newPosition);
                }
              },
              iconSize: 35,
              icon: const Icon(
                CupertinoIcons.gobackward_15,
                color: Colors.white,
              ),
            );
          },
        ),
        SizedBox(
          width: 25,
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64.0,
                  height: 64.0,
                  margin: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator(),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 75,
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                  ),
                  iconSize: 75.0,
                  onPressed: audioPlayer.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 75.0,
                  onPressed: () => audioPlayer.seek(
                    Duration.zero,
                    index: audioPlayer.effectiveIndices!.first,
                  ),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        SizedBox(
          width: 25,
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: () {
                final newPosition =
                    audioPlayer.position + Duration(seconds: 15) <
                            audioPlayer.duration!
                        ? () {
                            audioPlayer.seek(Duration(
                                seconds: audioPlayer.position.inSeconds + 15));
                          }
                        : null;

                if (newPosition != null) {
                  newPosition();
                }
              },
              iconSize: 35,
              icon: const Icon(
                CupertinoIcons.goforward_15,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  thumbShape: const RoundSliderThumbShape(
                    disabledThumbRadius: 0,
                    enabledThumbRadius: 0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Color.fromARGB(255, 255, 255, 255),
                  inactiveTrackColor: Color.fromARGB(255, 116, 108, 108),
                  thumbColor: Color.fromARGB(255, 255, 255, 255),
                  overlayColor: Color.fromARGB(255, 100, 97, 97),
                ),
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(
                    _dragValue ?? widget.position.inMilliseconds.toDouble(),
                    widget.duration.inMilliseconds.toDouble(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(
                        Duration(
                          milliseconds: value.round(),
                        ),
                      );
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangeEnd != null) {
                      widget.onChangeEnd!(
                        Duration(
                          milliseconds: value.round(),
                        ),
                      );
                    }
                    _dragValue = null;
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(widget.position),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                ),
                Text(
                  _formatDuration(widget.duration),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ],
            )),
      ],
    );
  }
}
