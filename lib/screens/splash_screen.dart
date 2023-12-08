import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:podcast/main.dart';
import 'package:podcast/widget/splashListView_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();
  ScrollController _scrollController4 = ScrollController();
  ScrollController _scrollController5 = ScrollController();
  ScrollController _scrollController6 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      double minScrollExtent3 = _scrollController3.position.minScrollExtent;
      double maxScrollExtent3 = _scrollController3.position.maxScrollExtent;
      //
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 15,
          _scrollController2);
      animateToMaxMin(maxScrollExtent3, minScrollExtent3, maxScrollExtent3, 20,
          _scrollController3);
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 45,
          _scrollController4);
      animateToMaxMin(maxScrollExtent3, minScrollExtent3, maxScrollExtent3, 20,
          _scrollController5);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 25,
          _scrollController6);
    });

    Future.delayed(Duration(seconds: 13), () {
      Get.toNamed(RouteName.homeScreen);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  List movies1 = [
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://i.pinimg.com/736x/d5/bb/93/d5bb939bf8936060c55d248f78196fa4.jpg',
    'https://qph.cf2.quoracdn.net/main-qimg-a7c2f2650f0a8e678efc9d1786f98802-lq',
  ];

  List movies2 = [
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
  ];

  List movies3 = [
    'https://i.pinimg.com/736x/d5/bb/93/d5bb939bf8936060c55d248f78196fa4.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
  ];

  List movies4 = [
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
  ];

  List movies5 = [
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://i.pinimg.com/736x/d5/bb/93/d5bb939bf8936060c55d248f78196fa4.jpg',
    'https://qph.cf2.quoracdn.net/main-qimg-a7c2f2650f0a8e678efc9d1786f98802-lq',
  ];
  List movies6 = [
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://imagevars.gulfnews.com/2023/09/19/Vijay_18aaba451cb_medium.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://www.koimoi.com/wp-content/new-galleries/2023/03/ar-rahman-its-heartbreaking-to-take-contestants-off-his-show-nexa-music-2-01.jpg',
    'https://filmyspace.in/wp-content/uploads/2022/07/4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Transform.scale(
            scale: 2.0,
            child: Transform.rotate(
              angle: -30 * (3.1415926535 / 180),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SplashListViewWidget(
                    scrollController: _scrollController1,
                    images: movies1,
                  ),
                  SplashListViewWidget(
                    scrollController: _scrollController2,
                    images: movies2,
                  ),
                  SplashListViewWidget(
                    scrollController: _scrollController3,
                    images: movies3,
                  ),
                  SplashListViewWidget(
                    scrollController: _scrollController4,
                    images: movies4,
                  ),
                  SplashListViewWidget(
                    scrollController: _scrollController5,
                    images: movies6,
                  ),
                  SplashListViewWidget(
                    scrollController: _scrollController6,
                    images: movies1,
                  ),
                ],
              ),
            )));
  }
}
