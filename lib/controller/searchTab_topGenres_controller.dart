import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/model/songsModel.dart';

class SearchTabTopGenresController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<SearchTabCategoryModel> topGenresResults =
      <SearchTabCategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  onInit() {
    fetchTopGenre();
    super.onInit();
  }

  Future<void> fetchTopGenre() async {
    isLoading.value = true;

    try {
      final List<SearchTabCategoryModel> results =
          await _apiService.search("tamil hits");
      topGenresResults.assignAll(results);

      isLoading.value = false;
    } catch (error) {
      print("Error fetching search results: $error");
      isLoading.value = false;
    }
  }
}
