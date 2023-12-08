import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/model/songsModel.dart';

class SearchTabController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<SearchTabCategoryModel> searchInputResults = <SearchTabCategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchSearchResult(String searchInput) async {
    isLoading.value = true;
    print(isLoading);

    try {
      final List<SearchTabCategoryModel> results =
          await _apiService.search(searchInput);
      searchInputResults.assignAll(results);

      isLoading.value = false;
      print("Search results fetched");
      print("--------------------------------");

      

      // SearchTabController.printSearchResults();
    } catch (error) {
      print("Error fetching search results: $error");
      isLoading.value = false;
      // Handle error as needed
    }
  }
}

