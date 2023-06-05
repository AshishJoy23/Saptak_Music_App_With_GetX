import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SeekByButtonWidget extends StatelessWidget {
  const SeekByButtonWidget({
    super.key,
    required this.audioPlayer,
    required this.icon,
    required this.forward,
  });

  final AssetsAudioPlayer audioPlayer;
  final IconData icon;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
      player: audioPlayer,
      builder: (context, isPlaying) {
        return IconButton(
          iconSize: 35,
          onPressed: (forward)
              ? () async {
                  await audioPlayer.seekBy(const Duration(seconds: 10));
                }
              : () async {
                  await audioPlayer.seekBy(const Duration(seconds: -10));
                },
          icon: Icon(icon, color: Colors.white, size: 35),
        );
      },
    );
  }
}
