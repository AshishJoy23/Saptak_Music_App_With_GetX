import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/play_pause_button.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/previous_next_button.dart';
import 'package:saptak_music_app/view/screens/nowplaying/widgets/seek_by_button.dart';

class MusicControlWidget extends StatelessWidget {
  const MusicControlWidget({
    super.key,
    required this.index,
    required this.length,
    required this.audioPlayer,
  });

  final int index;
  final int length;
  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.width;
    return Container(
      width: widthDsp * 0.85,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PreviousNextButtonWidget(
            index: index,
            audioPlayer: audioPlayer,
            icon: Icons.skip_previous,
            length: 0,
            forward: false,
          ),
          SeekByButtonWidget(
            audioPlayer: audioPlayer,
            icon: Icons.replay_10,
            forward: false,
          ),
          PlayPauseButtonWidget(
            audioPlayer: audioPlayer,
          ),
          SeekByButtonWidget(
            audioPlayer: audioPlayer,
            icon: Icons.forward_10,
            forward: true,
          ),
          PreviousNextButtonWidget(
            index: index,
            audioPlayer: audioPlayer,
            icon: Icons.skip_next,
            length: length - 1,
            forward: true,
          ),
        ],
      ),
    );
  }
}
