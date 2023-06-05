import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class NowPlayingProgressBarWidget extends StatelessWidget {
  const NowPlayingProgressBarWidget({
    super.key,
    required this.audioPlayer,
  });

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthDsp * 0.75,
      child: PlayerBuilder.realtimePlayingInfos(
        player: audioPlayer,
        builder: (context, realtimePlayingInfos) {
          final duration = realtimePlayingInfos.current!.audio.duration;
          final position = realtimePlayingInfos.currentPosition;
          return ProgressBar(
            progress: position,
            total: duration,
            progressBarColor: Colors.white,
            baseBarColor: Colors.white.withOpacity(0.5),
            thumbColor: const Color.fromARGB(255, 152, 248, 72),
            barHeight: 3.0,
            thumbRadius: 7.0,
            timeLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            onSeek: (duration) {
              audioPlayer.seek(duration);
            },
          );
        },
      ),
    );
  }
}
