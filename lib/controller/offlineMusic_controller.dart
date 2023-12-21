import 'dart:ffi';

import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/model/offlineSongsModel.dart';
import 'package:podcast/model/songsModel.dart';

MusicDetailsController _musicDetailsController =
    Get.put(MusicDetailsController());

class offlineMusicController extends GetxController {
  GlobalController _globalController = Get.put(GlobalController());

  RxList<SearchTabCategoryModel> searchInputResults =
      <SearchTabCategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  RxString url = "".obs;
  RxString filePath = "".obs;
  RxBool ok = false.obs;
  RxList<SearchTabCategoryModel> offlineSongsData =
      <SearchTabCategoryModel>[].obs;

  void dowload() async {
    isLoading.value = true;

    try {
      String results = await ApiService()
          .downloadFile(_musicDetailsController.songPreview.value.url);
      filePath.value = results;
      _globalController.offlineSongsList.add({
        "trackId": _musicDetailsController.songPreview.value.trackId,
        "location": filePath,
      });
      print(
          "[[[[[[[[[[[[[[-----------------------------------------]]]]]]]]]]]]]]");
      print(filePath);
      //add offline sonh data

      // Create a new Song object
      SearchTabCategoryModel newSong = SearchTabCategoryModel(
        url: filePath.value,
        artworkUrl100: _musicDetailsController.songPreview.value.artworkUrl100,
        collectionName:
            _musicDetailsController.songPreview.value.collectionName,
        trackName: _musicDetailsController.songPreview.value.trackName,
        artistName: _musicDetailsController.songPreview.value.artistName,
        trackId: _musicDetailsController.songPreview.value.trackId,
      );

      // Add the new song to the list
      offlineSongsData.add(newSong);
     

      isLoading.value = false;
      print(_globalController.offlineSongsList.length);
    } catch (error) {
      print("Error downloadinf file: $error");
      isLoading.value = false;
      // Handle error as needed
    }
  }

  void loadselectedofflinesongDetail(int index) {
    isLoading.value = true;
    _musicDetailsController.selectedSongDetails.value = offlineSongsData[index];
   
    _musicDetailsController.hiResImageSelected.value = "";
    isLoading.value = false;
  }
}
