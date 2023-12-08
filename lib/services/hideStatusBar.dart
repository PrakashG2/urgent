import 'package:flutter/services.dart';

Future hidestatusbar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}