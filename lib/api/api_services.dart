// services/api_service.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'dart:convert';

import 'package:podcast/model/songsModel.dart';

SearchTabController _searchTabController = Get.put(SearchTabController());
offlineMusicController _offlineMusicController =
      Get.put(offlineMusicController());

class ApiService {
  String searchInput = "";
  Future<List<SearchTabCategoryModel>> listenNow_topChart() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://itunes.apple.com/search?term=imagine+dragons&media=album&entity=song&limit=5&offset=5'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        List<SearchTabCategoryModel> searchTabCategoryResults = results
            .map((json) => SearchTabCategoryModel.fromJson(json))
            .toList();

        return searchTabCategoryResults;
      } else {
        throw Exception('Failed to load tracks');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error as needed
      return [];
    }
  }

  Future<List<SearchTabCategoryModel>> search(String Input) async {
    searchInput = Input;
    List<SearchTabCategoryModel> searchResults = [];
    final response = await http.get(
      Uri.parse(
          'https://itunes.apple.com/search?term=${searchInput}&media=music&entity=song'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      searchResults =
          results.map((json) => SearchTabCategoryModel.fromJson(json)).toList();
      print(searchResults);

      return searchResults;
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  Future<List<SearchTabCategoryModel>> fetchMore(
      String searchText, int offset) async {
    List<SearchTabCategoryModel> searchResults = [];
    final response = await http.get(
      Uri.parse(
          'https://itunes.apple.com/search?term=${searchText}&media=music&entity=song&offset=${offset}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      searchResults =
          results.map((json) => SearchTabCategoryModel.fromJson(json)).toList();
      print(searchResults);
      print(offset);

      return searchResults;
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  Future<List<SearchTabCategoryModel>> moreFromCreator(
      String searchInput) async {
    print("+=+====+++++===++++++]]]]]]]]]]]]]]]]]]]]]]]]]]");
    print(searchInput);

    List<SearchTabCategoryModel> searchResults = [];
    final response = await http.get(
      Uri.parse(
          'https://itunes.apple.com/search?term=${searchInput}&entity=song&offset=5'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      searchResults =
          results.map((json) => SearchTabCategoryModel.fromJson(json)).toList();
      print(searchResults);

      return searchResults;
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  Future<List<SearchTabCategoryModel>> SearchTabTopGenres(
      String GenreInput) async {
    List<SearchTabCategoryModel> genreResults = [];
    final response = await http.get(
      Uri.parse(
          'https://itunes.apple.com/search?term=${GenreInput}&entity=song&offset=5'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      genreResults =
          results.map((json) => SearchTabCategoryModel.fromJson(json)).toList();

      return genreResults;
    } else {
      throw Exception('Failed to load tracks');
    }
  }
 
  Future<String> downloadFile(url) async {
    
    String dir = "/storage/emulated/0/Download";
    String localFilePath = '$dir/${DateTime.now().millisecondsSinceEpoch}.mp3';

    // Using HttpClient for download
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    List<int> bytes = await consolidateHttpClientResponseBytes(response);

    // Save the bytes to the local file
    File file = File(localFilePath);
    await file.writeAsBytes(bytes);

    print('File downloaded to: $localFilePath');
    

    return localFilePath;
  }

}
