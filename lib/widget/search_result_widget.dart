import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/controller/moreFromCreator_widget_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/searc_result_widget_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'package:podcast/main.dart';
import 'package:podcast/widget/progress_indicator.dart';
import 'package:podcast/widget/search_result_customScrollableText.dart';

class SearchResultWidget extends StatefulWidget {
  SearchResultWidget({Key? key});

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchResultWidgetController.lastItem.value = true;
      } else {
        _searchResultWidgetController.lastItem.value = false;
      }
    });
  }

  bool lastItem = false;
  ScrollController _scrollController = ScrollController();

  final SearchTabController _searchTabController =
      Get.put(SearchTabController());

  final SearchResultWidgetController _searchResultWidgetController =
      Get.put(SearchResultWidgetController());

  final MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());

  final MoreFromCreatorWidgetController _moreFromCreatorWidgetController =
      Get.put(MoreFromCreatorWidgetController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_searchTabController.isLoading.value) {
          return const CustomProgressIndicator();
        }

        if (_searchTabController.searchInputResults.isEmpty) {
          return const Center(
            child: Text("NO RESULT FOUND"),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: _searchTabController.searchInputResults.length,
          itemBuilder: (context, index) {
            final result = _searchTabController.searchInputResults[index];

            return GestureDetector(
              onTap: () {
                _musicDetailsController.loadPreviewSongDetails(index);
                Get.toNamed(RouteName.musicDetailsScreen);
                _moreFromCreatorWidgetController.fetchmorefromCreatorResult();
              },
              child: Theme(
                data: ThemeData(
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    brightness: Brightness.light,
                    primaryColor: CupertinoColors.systemGrey,
                    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 211, 209, 209),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 89, 89, 92).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            fadeOutDuration: Duration(milliseconds: 400),
                            placeholder:AssetImage("assets/loading.gif"),
                            image: NetworkImage(result.artworkUrl100),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: result.trackName),
                            CustomText(text: result.artistName),
                            CustomText(text: result.collectionName)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
