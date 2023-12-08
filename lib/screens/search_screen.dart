import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/api/api_services.dart';
import 'package:podcast/controller/searc_result_widget_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'package:podcast/widget/progress_indicator.dart';
import 'package:podcast/widget/searchTab_topGenres_widget.dart';
import 'package:podcast/widget/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //----------------------------------------------------------------------------> controller instances
  final SearchTabController _searchTabController =
      Get.put(SearchTabController());
  final SearchResultWidgetController _searchResultWidgetController =
      Get.put(SearchResultWidgetController());

  TextEditingController searchInputController = TextEditingController();
  bool lastItem = false;
  String serachInput = "";
  Map<String, int> offsetValues = {};

  //--------------------> CATEGORY

  // @override
  // void initState() {
  //   super.initState();
  //   _.fetchSearchResult("vijayantony");
  // }

  Future<void> fetchMore() async {
    _searchResultWidgetController.isLoading.value = true;

    int offsetValue = offsetValues[serachInput] ?? 0;

    final resultData =
        await ApiService().fetchMore(searchInputController.text, offsetValue);
    setState(() {
      lastItem = !lastItem;
      _searchTabController.searchInputResults.addAll(resultData);
      offsetValues[serachInput] = offsetValue + 50;
    });
    _searchResultWidgetController.isLoading.value = false;
    _searchResultWidgetController.lastItem.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search",
              style: TextStyle(fontSize: 25),
            ),
            CupertinoSearchTextField(
              controller: searchInputController,
              placeholder: 'Shows, Episodes and more',
              suffixIcon: const Icon(CupertinoIcons.mic),
              onChanged: (String value) {
                setState(() {
                  serachInput = value;
                });
              },
              onSubmitted: (String value) async {
                _searchTabController.fetchSearchResult(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            serachInput.isEmpty
                ? TopGenresWidget()
                : Expanded(
                    child: SearchResultWidget(),
                  ),
            Obx(() => _searchResultWidgetController.lastItem.value
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    child: _searchResultWidgetController.isLoading.value
                        ? const CustomProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              fetchMore();
                            },
                            child: Text('Show More'),
                          ),
                  )
                : Container())
            // MinimizablePlayer()
          ],
        ),
      ),
    );
  }
}
