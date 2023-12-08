import 'package:get/get.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/moreFromCreator_widget_controller.dart';
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'package:podcast/controller/searchTab_topGenres_controller.dart';
import 'package:podcast/model/songsModel.dart';

GlobalController _globalController = Get.put(GlobalController());

class MusicDetailsController extends GetxController {
  final SearchTabController _searchTabController =
      Get.put(SearchTabController());
  final SearchTabTopGenresController _searchTabTopGenresController =
      Get.put(SearchTabTopGenresController());

  RxBool isLoading = false.obs;
  RxBool offline = false.obs;

  RxString hiResImagePreview = ''.obs;
  RxString hiResImageSelected = ''.obs;
        RxString location = "".obs;


  Rx<SearchTabCategoryModel> songPreview = Rx<SearchTabCategoryModel>(
    SearchTabCategoryModel(
      trackName: '',
      artworkUrl100: '',
      url: '',
      trackId: 0,
      artistName: '',
      collectionName: '',
    ),
  );
  Rx<SearchTabCategoryModel> selectedSongDetails = Rx<SearchTabCategoryModel>(
    SearchTabCategoryModel(
      trackName: '',
      artworkUrl100: '',
      url: '',
      trackId: 0,
      artistName: '',
      collectionName: '',
    ),
  );

  void loadPreviewSongDetails(int index) {
    isLoading.value = true;
    songPreview.value = _searchTabController.searchInputResults[index];

    String modifiedString =
        songPreview.value.artworkUrl100.replaceAll("100x100", "1920x1080");

    hiResImagePreview.value = modifiedString;
    isLoading.value = false;
  }

  void loadPreviewSongDetailsfromOffline() {
    isLoading.value = true;
    print("----------------- contro");

    // // For demonstration purposes, using dummy strings
    // songPreview.value = SearchTabCategoryModel(
    //     trackId: 123,
    //     trackName: 'Downloaded Song',
    //     artistName: 'Dummy Artist',
    //     collectionName: 'Dummy Album',
    //     artworkUrl100:
    //         "https://t4.ftcdn.net/jpg/04/35/65/05/360_F_435650529_fdtx8euYTrcxH5NEAWONH2zQYOEWfgrA.jpg", // Use the provided URL for artwork
    //     url: url);

    if (offline.value) {
      print("------------********-++++++++++++5555555555555555555----- contro");
      print(offline);

     _globalController.offlineSongsList.any((item) {
  print('Checking item: $item, trackId: ${item["trackId"]}, target trackId: ${songPreview.value.trackId}');

  if (item["trackId"] == songPreview.value.trackId) {
    location = item["location"];
    print('Match found! Updated location: $location');
    return true; // Exit the loop once a match is found
  }

  print('No match for trackId: ${item["trackId"]}');
  return false;
});


      isLoading.value = true;
      hiResImageSelected.value = hiResImagePreview.value;
      isLoading.value = false;
print("9999999999999999999999999999999999999999999 ${location}");
      songPreview.value = SearchTabCategoryModel(
        trackId: songPreview.value.trackId,
        trackName:  songPreview.value.trackName,
        artistName: songPreview.value.artistName,
        collectionName: songPreview.value.collectionName,
        artworkUrl100:
            "https://t4.ftcdn.net/jpg/04/35/65/05/360_F_435650529_fdtx8euYTrcxH5NEAWONH2zQYOEWfgrA.jpg",
        url: location.value,
      );
    }

    // Modify the URL for high-resolution image preview
    String modifiedString =
        songPreview.value.artworkUrl100.replaceAll("100x100", "1920x1080");
    hiResImagePreview.value = modifiedString;

    isLoading.value = false;
  }

  void loadPreviewFromTopGenres(int index) {
    isLoading.value = true;
    songPreview.value = _searchTabTopGenresController.topGenresResults[index];

    String modifiedString =
        songPreview.value.artworkUrl100.replaceAll("100x100", "1920x1080");

    hiResImagePreview.value = modifiedString;
    isLoading.value = false;
  }

  void loadselectedsongDetail() {
    isLoading.value = true;
    selectedSongDetails.value = songPreview.value;
    print(
        "++++++++++++++++++++++++++++++------------------------********************");
    print(selectedSongDetails.value.url);
    hiResImageSelected.value = hiResImagePreview.value;
    isLoading.value = false;
  }
}
