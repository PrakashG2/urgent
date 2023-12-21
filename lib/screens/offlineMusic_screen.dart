// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:podcast/controller/musicDetails_controller.dart';
// import 'package:podcast/controller/offlineMusic_controller.dart';
// import 'package:podcast/main.dart';

// class offlineMusicScreen extends StatefulWidget {
//   offlineMusicScreen();

//   @override
//   _offlineMusicScreenState createState() => _offlineMusicScreenState();
// }

// class _offlineMusicScreenState extends State<offlineMusicScreen> {
//   String finalPath = "";
//   MusicDetailsController _musicDetailsController =
//       Get.put(MusicDetailsController());

//   String localFilePath = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Offline Audio Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.download_rounded),
//               onPressed: () {
//                 // _offlineMusicController.dowload();
//               },
//             ),
//             SizedBox(height: 20),
//             Text('File Path: $localFilePath'),
//             IconButton(
//               icon: Icon(Icons.play_arrow),
//               onPressed: () {
//                 // _musicDetailsController
//                 //     .loadPreviewSongDetailsfromOffline(finalPath);
//                 // print("----------------");
//                 // print(_musicDetailsController.songPreview.value.url);
//                 // Get.toNamed(RouteName.musicDetailsScreen);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/controller/musicDetails_controller.dart';
import 'package:podcast/controller/offlineMusic_controller.dart';
import 'package:podcast/main.dart';
import 'package:podcast/widget/search_result_customScrollableText.dart';

class offlineMusicScreen extends StatefulWidget {
  offlineMusicScreen();

  @override
  _offlineMusicScreenState createState() => _offlineMusicScreenState();
}

class _offlineMusicScreenState extends State<offlineMusicScreen> {
  offlineMusicController _offlineMusicController =
      Get.put(offlineMusicController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Offline Audio Player'),
        ),
        body:Obx(() => _offlineMusicController.offlineSongsData.isEmpty ?
      Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage("assets/nothing.gif"),),
                    SizedBox(height: 20,),
                    Text("No Downloads yet !")
          ],
        ) :
      
   
         Padding(
          padding: EdgeInsets.all(10),
          child:ListView.builder(
              itemCount: _offlineMusicController.offlineSongsData.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _offlineMusicController.loadselectedofflinesongDetail(index);
                  Get.toNamed(RouteName.musicPlayerScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: AssetImage("assets/cd.png"),
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: _offlineMusicController
                                      .offlineSongsData[index].trackName),
                              CustomText(
                                  text: _offlineMusicController
                                      .offlineSongsData[index].artistName),
                              CustomText(
                                  text: _offlineMusicController
                                      .offlineSongsData[index].collectionName)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
