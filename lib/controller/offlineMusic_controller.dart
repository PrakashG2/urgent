import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
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
      print(_globalController.offlineSongsList[1]["track id"]);
      isLoading.value = false;
      print(_globalController.offlineSongsList.length);
    } catch (error) {
      print("Error downloadinf file: $error");
      isLoading.value = false;
      // Handle error as needed
    }
  }
}
