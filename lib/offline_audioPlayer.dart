import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class OfflineAudioPlayer extends StatefulWidget {
  OfflineAudioPlayer();

  @override
  _OfflineAudioPlayerState createState() => _OfflineAudioPlayerState();
}

class _OfflineAudioPlayerState extends State<OfflineAudioPlayer> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    String localFilePath = await _downloadFile(
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/84/8c/7c/848c7ce2-a6bc-8d24-f6b5-6f9c9d0ab3a2/mzaf_9027500589880693698.plus.aac.p.m4a");

    print('Local File Path: $localFilePath');

    await _audioPlayer.setFilePath(localFilePath);
    _audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      print('Processing State: ${event.processingState}');
      if (event.processingState == ProcessingState.completed) {
        print('Audio playback completed');
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  Future<String> _downloadFile(String url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String localFilePath = '$dir/${DateTime.now().millisecondsSinceEpoch}.mp3';

    print('Downloading file from: $url');

    // Using HttpClient for download
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    List<int> bytes = await consolidateHttpClientResponseBytes(response);

    // Save the bytes to the local file
    File file = File(localFilePath);
    await file.writeAsBytes(bytes);

    print('File downloaded to: $localFilePath');

    return localFilePath;
  }

  void _togglePlayback() {
    if (_isPlaying) {
      _audioPlayer.pause();
      print('Audio paused');
    } else {
      _audioPlayer.play();
      print('Audio started playing');
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _togglePlayback,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

void main() {
  runApp(
    MaterialApp(
      home: OfflineAudioPlayer(),
    ),
  );
}
