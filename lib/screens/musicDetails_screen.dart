import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/main.dart';
import 'package:podcast/widget/moreFromCreatore_widget.dart';

class MusicDetailsScreen extends StatefulWidget {
  const MusicDetailsScreen({super.key});

  @override
  State<MusicDetailsScreen> createState() => _MusicDetailsScreenState();
}

class _MusicDetailsScreenState extends State<MusicDetailsScreen> {
  // int index = int.tryParse(Get.parameters['index'] ?? '') ?? 0;
  int index = 5;

  final MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());

  final offlineMusicController _offlineMusicController =
      Get.put(offlineMusicController());

  final GlobalController _globalController = Get.put(GlobalController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _loadSelectedSongDetails();
  //   });
  // }

  // void _loadSelectedSongDetails() {
  //   _musicDetailsController.loadpreviewSongDetails(index);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 550,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _musicDetailsController.isLoading.value
                            ? CircularProgressIndicator()
                            : FadeInImage(
                                fadeOutDuration: Duration(milliseconds: 400),
                                placeholder: NetworkImage(
                                    "https://cencalpsych.org/sites/cencalpsych.org/files/loading.gif"),
                                image: NetworkImage(_musicDetailsController
                                    .hiResImagePreview.value),
                                fit: BoxFit.cover,
                              ),

                        const Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 170,
                            child: _BackgroundFilter()),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(bottom: 20.0),
                        //     child: Text(
                        //       widget.trackName,
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 20,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 210,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Adjust the radius as needed
                                ),
                                padding: const EdgeInsets.all(
                                    10.0), // Adjust the padding as needed
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteName.musicPlayerScreen);
                                        _musicDetailsController
                                            .loadselectedsongDetail();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.play_arrow_solid,
                                        size: 20,
                                      ),
                                    ),
                                    Text("P L A Y")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _musicDetailsController
                                            .songPreview.value.trackName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _musicDetailsController
                                            .songPreview.value.artistName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _musicDetailsController
                                            .songPreview.value.collectionName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (!_globalController
                                              .offlineSongsList
                                              .any((item) =>
                                                  item["trackId"] ==
                                                  _musicDetailsController
                                                      .songPreview
                                                      .value
                                                      .trackId))
                                            IconButton(
                                                onPressed: () {
                                                  _offlineMusicController
                                                          .url.value =
                                                      _musicDetailsController
                                                          .songPreview
                                                          .value
                                                          .url;
                                                  _offlineMusicController
                                                      .dowload();
                                                  _musicDetailsController
                                                      .loadPreviewSongDetailsfromOffline();

                                                  //                                   _musicDetailsController
                                                  // .loadPreviewSongDetailsfromOffline(_offlineMusicController.filePath.value);
                                                },
                                                icon: const Icon(
                                                  Icons.download_rounded,
                                                  size: 30,
                                                ))
                                          else
                                            IconButton(
                                                onPressed: () {
                                                  _musicDetailsController
                                                      .offline.value = true;
                                                  _musicDetailsController
                                                      .loadPreviewSongDetailsfromOffline();
                                                  // _musicDetailsController
                                                  //     .loadselectedsongDetail();

                                                  Get.toNamed(RouteName
                                                      .musicPlayerScreen);
                                                },
                                                icon: const Icon(
                                                  Icons.download_done,
                                                  size: 30,
                                                ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.tealAccent,
                    child: Center(
                      child: Text("M O R E   F R O M   C R E A T O R"),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      height: 250,
                      child: _musicDetailsController.isLoading.value
                          ? const CircularProgressIndicator()
                          : MoreFromeCreatorWidget()),
                ],
              ),
            )));
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 50),
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
