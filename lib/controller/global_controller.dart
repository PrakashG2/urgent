import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast/controller/musicDetails_controller.dart';

MusicDetailsController _musicDetailsController =
    Get.put(MusicDetailsController());


class GlobalController extends GetxController {
  RxBool isExpanded = true.obs;
  RxBool isFirstSongPlayed = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  RxInt index = 0.obs;
  RxString currentPlayingUrl = ''.obs;
  MusicDetailsController _musicDetailsController =
      Get.put(MusicDetailsController());
  RxList<Map<String, dynamic>> offlineSongsList = <Map<String, dynamic>>[].obs;

  RxBool miniPlayerVisibility = true.obs;

  void initializeAudioPlayer() {
    print("12-++++++++++++++++++++++++++++++------------------------********************** ${_musicDetailsController.selectedSongDetails.value.url}");
    if (_musicDetailsController.offline.value) {
          print("12-++++++++++++++++++++++++++++++------------------------********************** ${_musicDetailsController.location}");

      
    }
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          _musicDetailsController.offline.value ? 
         AudioSource.file(_musicDetailsController.location.value, 
            tag: MediaItem(
              id: '1',
              album: _musicDetailsController
                  .selectedSongDetails.value.collectionName,
              title:
                  _musicDetailsController.selectedSongDetails.value.trackName,
              artUri: Uri.parse(_musicDetailsController
                  .selectedSongDetails.value.artworkUrl100),
            ),
          ):  AudioSource.uri(
            Uri.parse(_musicDetailsController.selectedSongDetails.value.url), tag: MediaItem(
              id: '1',
              album: _musicDetailsController
                  .selectedSongDetails.value.collectionName,
              title:
                  _musicDetailsController.selectedSongDetails.value.trackName,
              artUri: Uri.parse(_musicDetailsController
                  .selectedSongDetails.value.artworkUrl100),
            ))
        ],
      ),
      initialIndex: 0,
      initialPosition: Duration.zero,
      preload: true,
    );
    currentPlayingUrl.value =
        _musicDetailsController.selectedSongDetails.value.url;
  }
}
