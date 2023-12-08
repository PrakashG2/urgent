import 'package:get/get.dart';

class LandingController extends GetxController {
  RxString sample = "sample controller data".obs;


   

  @override
  void onInit() {
    print("==========================================================+++++++++++++++++++++Controller Initialized");
    super.onInit();
  }
}
