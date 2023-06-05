import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PlayPauseButtonWidget extends StatelessWidget {
  const PlayPauseButtonWidget({
    super.key,
    required this.audioPlayer,
  });

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
      player: audioPlayer,
      builder: (context, isPlaying) {
        return IconButton(
          iconSize: 55,
          onPressed: () {
            audioPlayer.playOrPause();
          },
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: const Color.fromARGB(255, 152, 248, 72),
            size: 55,
          ),
        );
      },
    );
  }
}
