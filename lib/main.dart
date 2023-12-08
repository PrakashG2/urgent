import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast/controller/moreFromCreator_widget_controller.dart';
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/controller/searc_result_widget_controller.dart';
import 'package:podcast/controller/searchTab_controller.dart';
import 'package:podcast/offline_audioPlayer.dart';
import 'package:podcast/screens/home_screen.dart';
import 'package:podcast/controller/landing_controller.dart';
import 'package:podcast/screens/landing_screen.dart';
import 'package:podcast/screens/musicDetails_screen.dart';
import 'package:podcast/screens/musicPlayer_screen.dart';
import 'package:podcast/screens/offlineMusic_screen.dart';
import 'package:podcast/screens/search_screen.dart';
import 'package:podcast/screens/splash_screen.dart';
import 'package:podcast/services/hideStatusBar.dart';
import 'package:podcast/widget/searchTab_topGenres_widget.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  // await hidestatusbar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'podcast getx try 2',
      debugShowCheckedModeBanner: false,
      getPages: GetPages.getPages,
      initialBinding: RootBindings(),
      initialRoute: RouteName.splashScreen,
    );
  }
}

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchTabController());
    Get.put(MoreFromCreatorWidgetController());
    Get.put(SearchResultWidgetController());
    Get.put(LandingController());
    Get.put(TopGenresWidget());
  }
}

class RouteName {
  static const String splashScreen = "/splashScreen";
  static const String homeScreen = "/homeScreen";
  static const String landingScreen = "/landingScreen";

  static const String searchScreen = "/searchScreen";
  static const String musicDetailsScreen = "/musicDetailsScreen";
  static const String musicPlayerScreen = "/musicPlayerScreen";

  static const String offlineMusicScreen = "/offlineMusicScreen";

  static const String ScreenOne = "/screenOne";
  static const String ScreenTwo = "/screenTwo";
  static const String ScreenThree = "/screenThree";
}

class GetPages {
  static List<GetPage> get getPages => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: RouteName.musicDetailsScreen,
          page: () => MusicDetailsScreen(),
        ),
        GetPage(
          name: RouteName.musicPlayerScreen,
          page: () => musicPlayerScreen(),
        ),
        GetPage(
          name: RouteName.landingScreen,
          page: () => LandingScreen(),
        ),
        GetPage(
          name: RouteName.searchScreen,
          page: () => SearchScreen(),
        ),
        GetPage(
          name: RouteName.offlineMusicScreen,
          page: () => offlineMusicScreen(),
        ),
      ];
}
