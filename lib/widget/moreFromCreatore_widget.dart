import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/controller/moreFromCreator_widget_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/main.dart';
import 'package:podcast/model/songsModel.dart';
import 'package:podcast/screens/musicPlayer_screen.dart';
import 'package:podcast/widget/progress_indicator.dart';

class MoreFromeCreatorWidget extends StatelessWidget {
  MoreFromeCreatorWidget({super.key});

  // Controller instance
  final MoreFromCreatorWidgetController _moreFromCreatorWidgetController =
      Get.put(MoreFromCreatorWidgetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(() {
        if (_moreFromCreatorWidgetController.isLoading.value) {
          return const Center(
            child: CustomProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount:
              _moreFromCreatorWidgetController.morefromCreatorResult.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              //  _musicDetailsController.loadPreviewSongDetails(2);
              //     Get.toNamed(RouteName.musicPlayerScreen);
              _moreFromCreatorWidgetController.loadmorefromCreatorData(index);
              
              Get.toNamed(RouteName.musicDetailsScreen);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    _moreFromCreatorWidgetController
                        .morefromCreatorResult[index].artworkUrl100,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white,
                          ],
                          stops: [0.5, 0.5, 0.7],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                        height: 1920,
                        width: 1080,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromARGB(255, 0, 0, 0),
                              const Color.fromARGB(255, 0, 0, 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _moreFromCreatorWidgetController
                                        .morefromCreatorResult[index].trackName,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    _moreFromCreatorWidgetController
                                        .morefromCreatorResult[index]
                                        .collectionName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
