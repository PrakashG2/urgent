import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LandingController extends GetxController {
  RxString sample = "sample controller data".obs;
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    internetConnectivity(); // Call the function here
  }

  void internetConnectivity() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      isConnected.value = status == InternetConnectionStatus.connected;
      print("Connection Status Changed: ${isConnected.value}");
      if (isConnected.value) {
        Get.snackbar("INTERNET CONNECTIVITY", "WE ARE BACK ONLINE",backgroundColor: Colors.green);
      }else {
        Get.snackbar("INTERNET CONNECTIVITY", "NO INTERNET CONNECTIVITY",backgroundColor: Colors.red);
      }
    });
  }
}
