import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PreviousNextButtonWidget extends StatelessWidget {
  const PreviousNextButtonWidget({
    super.key,
    required this.index,
    required this.audioPlayer,
    required this.icon,
    required this.length,
    required this.forward,
  });

  final AssetsAudioPlayer audioPlayer;
  final IconData icon;
  final int length;
  final int index;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
      player: audioPlayer,
      builder: (context, isPlaying) {
        return IconButton(
          iconSize: 35,
          onPressed: index == length
              ? () {}
              : () async {
                  if (forward) {
                    await audioPlayer.next();
                  } else {
                    await audioPlayer.previous();
                  }
                  if (!isPlaying) {
                    await audioPlayer.pause();
                  }
                },
          icon: index == length
              ? Icon(
                  icon,
                  color: Colors.white.withOpacity(0.4),
                  size: 35,
                )
              : Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                ),
        );
      },
    );
  }
}
