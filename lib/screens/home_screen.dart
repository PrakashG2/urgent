import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:podcast/controller/global_controller.dart';
import 'package:podcast/screens/offlineMusic_screen.dart';

//screen imports
import 'package:podcast/screens/search_screen.dart';
import 'package:podcast/widget/minimizablePlayer.dart';
import 'package:podcast/screens/landing_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final screens = [const LandingScreen(), const SearchScreen(), offlineMusicScreen()];
  final _controller = PersistentTabController(initialIndex: 0);
  GlobalController _globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Positioned(top: 0, left: 0, child: MinimizablePlayer()),
        PersistentTabView(
          context, controller: _controller,
          screens: screens,
          items: _navBarsItems(),
          confineInSafeArea: true,
          // hideNavigationBar: _hideNavBar,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: 70,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12, blurRadius: 5, spreadRadius: 1)
              ]),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style12,
        ),_globalController.miniPlayerVisibility.value ?
        const Positioned(
            bottom: 80, left: 0, right: 0, child: MinimizablePlayer()) : Container()
      ],
    ));
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        title: "title", iconSize: 20, icon: const Icon(CupertinoIcons.play)),
    PersistentBottomNavBarItem(
        title: "title", iconSize: 20, icon: const Icon(CupertinoIcons.search)),
        PersistentBottomNavBarItem(
        title: "title", iconSize: 20, icon: const Icon(CupertinoIcons.wifi_exclamationmark)),
  ];
}
