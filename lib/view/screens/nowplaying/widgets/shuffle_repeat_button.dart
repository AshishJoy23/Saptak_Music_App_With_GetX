import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/app_controller.dart';

class ShuffleRepeatButtonWidget extends StatelessWidget {
  const ShuffleRepeatButtonWidget({
    super.key,
    required this.audioPlayer,
  });

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final AppController nowplayController = Get.put(AppController());
    final widthDsp = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthDsp * 0.75,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                nowplayController.isRepeat.value =
                    !nowplayController.isRepeat.value;
                if (nowplayController.isRepeat.value) {
                  audioPlayer.setLoopMode(LoopMode.single);
                } else {
                  audioPlayer.setLoopMode(LoopMode.none);
                }
              },
              icon: (nowplayController.isRepeat.value)
                  ? const Icon(Icons.repeat_on, color: Colors.white)
                  : const Icon(Icons.repeat, color: Colors.white),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {
                audioPlayer.toggleShuffle();
                nowplayController.isShuffle.value =
                    audioPlayer.isShuffling.value;
              },
              icon: (nowplayController.isShuffle.value)
                  ? const Icon(Icons.shuffle_on_outlined, color: Colors.white)
                  : const Icon(Icons.shuffle, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
