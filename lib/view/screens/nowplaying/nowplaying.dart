import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/music_control.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/nowplaying_appbar.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/nowplaying_bg_image.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/nowplaying_image.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/nowplaying_listtile.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/nowplaying_progressbar.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/shuffle_repeat_button.dart';

class ScreenNowPlaying extends StatelessWidget {
  final int index;

  const ScreenNowPlaying({required this.index, super.key});
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return audioPlayer.builderCurrent(builder: (context, playing) {
      return Stack(
        children: [
          NowPlayingBGWidget(
            id: playing.audio.audio.metas.id!,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: heightDsp,
              width: widthDsp,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(1),
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NowPlayingAppbarWidget(
                      id: playing.audio.audio.metas.id!,
                    ),
                    NowPlayingImageWidget(
                      id: playing.audio.audio.metas.id!,
                    ),
                    Padding(
                      padding: EdgeInsets.all(heightDsp * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: widthDsp * 0.75,
                            child: NowPlayingListTileWidget(
                              id: playing.audio.audio.metas.id!,
                              currentAudioTitle:
                                  audioPlayer.getCurrentAudioTitle,
                              currentAudioArtist:
                                  audioPlayer.getCurrentAudioArtist,
                            ),
                          ),
                          SizedBox(
                            height: heightDsp * 0.018,
                          ),
                          NowPlayingProgressBarWidget(audioPlayer: audioPlayer)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightDsp * 0.02,
                    ),
                    ShuffleRepeatButtonWidget(audioPlayer: audioPlayer),
                    SizedBox(height: heightDsp * 0.02),
                    MusicControlWidget(
                      index: playing.index,
                      length: playing.playlist.audios.length,
                      audioPlayer: audioPlayer,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
