import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/controller/moreFromCreator_widget_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/searchTab_topGenres_controller.dart';
import 'package:podcast/main.dart';

class TopGenresWidget extends StatelessWidget {
  final SearchTabTopGenresController _topGenresController =
      Get.put(SearchTabTopGenresController());
  final MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());
  final MoreFromCreatorWidgetController _moreFromCreatorWidgetController =
      Get.put(MoreFromCreatorWidgetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Genre",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                CircleAvatar(
                  child: Icon(Icons.music_note),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text(
                "Melodiene",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Icon(CupertinoIcons.right_chevron),
            ],
          ),
          SizedBox(
            height: 355,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _topGenresController.topGenresResults.length,
                itemBuilder: (context, index) {
                  var song = _topGenresController.topGenresResults[index];
                  return GestureDetector(
                    onTap: () {
                      _musicDetailsController.loadPreviewFromTopGenres(index);
                      Get.toNamed(RouteName.musicDetailsScreen);
                      _moreFromCreatorWidgetController
                          .fetchmorefromCreatorResult();
                    },
                    child: Container(
                      width: 250,
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Image.network(
                              song.artworkUrl100,
                              height: 1920,
                              width: 1080,
                              fit: BoxFit.fitHeight,
                            ),
                            Positioned(
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.trackName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        song.collectionName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        song.artistName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .play_arrow_solid,
                                                  size: 15,
                                                ),
                                                Text(
                                                  "14 m",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const TextButton(
                                            onPressed: null,
                                            child: Text(
                                              "...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
