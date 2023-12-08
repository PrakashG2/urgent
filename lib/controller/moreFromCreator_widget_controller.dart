import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'package:podcast/model/songsModel.dart';

class MoreFromCreatorWidgetController extends GetxController {
  final ApiService _apiService = ApiService();
  MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());

  final SearchTabController _searchTabController =
      Get.put(SearchTabController());

       

  RxList<SearchTabCategoryModel> morefromCreatorResult =
      <SearchTabCategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  void dispose() {
    morefromCreatorResult = RxList(<SearchTabCategoryModel>[]);
  }

  Future<void> fetchmorefromCreatorResult() async {
    String creatorData = _musicDetailsController.songPreview.value.artistName;
    creatorData = creatorData.replaceAll(RegExp(r'[^a-zA-Z0-9&]'), ' ');

    try {
      final List<SearchTabCategoryModel> results =
          await _apiService.moreFromCreator(creatorData);
      morefromCreatorResult.assignAll(results);

      _musicDetailsController.isLoading.value = false;
    } catch (error) {
      print("Error fetching search results: $error");
      _musicDetailsController.isLoading.value = false;
    }
  }

  void loadmorefromCreatorData(int index) {
    _musicDetailsController.isLoading.value = true;

    _musicDetailsController.songPreview.value = morefromCreatorResult[index];

    String modifiedString = morefromCreatorResult[index]
        .artworkUrl100
        .replaceAll("100x100", "1920x1080");

    _musicDetailsController.hiResImagePreview.value = modifiedString;

    _musicDetailsController.isLoading.value = false;
  }
}
