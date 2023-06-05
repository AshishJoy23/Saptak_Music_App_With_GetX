import 'package:flutter/material.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.width;
    final heightDsp = MediaQuery.of(context).size.height;
    return AboutDialog(
      applicationIcon: Container(
        height: heightDsp * 0.09,
        width: widthDsp * 0.18,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/saptak_icon.png'),
          ),
        ),
      ),
      applicationName: "Saptak",
      applicationVersion: '1.0.0',
      applicationLegalese: 'Copyright © 2023 Saptak',
      children: [
        const Text(
            "Saptak is an offline music player app which allows users to listen to music from their storage. It provides features like adding to favorites, creating playlists, recently played, mostly played, etc."),
        SizedBox(
          height: heightDsp * 0.02,
        ),
        const Text("App developed by Ashish Joy."),
      ],
    );
  }
}
