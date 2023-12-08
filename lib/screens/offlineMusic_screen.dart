import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/main.dart';

class offlineMusicScreen extends StatefulWidget {
  offlineMusicScreen();

  @override
  _offlineMusicScreenState createState() => _offlineMusicScreenState();
}

class _offlineMusicScreenState extends State<offlineMusicScreen> {
  String finalPath = "";
  MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());
 
  String localFilePath = '';

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
              icon: Icon(Icons.download_rounded),
              onPressed: () {
                // _offlineMusicController.dowload();
              },
            ),
            SizedBox(height: 20),
            Text('File Path: $localFilePath'),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                // _musicDetailsController
                //     .loadPreviewSongDetailsfromOffline(finalPath);
                // print("----------------");
                // print(_musicDetailsController.songPreview.value.url);
                // Get.toNamed(RouteName.musicDetailsScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
