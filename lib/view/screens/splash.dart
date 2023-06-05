// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/app.dart';

import '../../model/db_functions.dart';



class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}


class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    requestPermission();
    goToMyApp();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 1, 10),
      body: Center(
          child: Row(
            children: [
              SizedBox(
                width: width1*0.06,
              ),
              SizedBox(
                //color: Colors.amber,
                width: width1*0.8,
                child: Stack(children: [
                  const Icon(
                    Icons.music_note_rounded,
                    size: 158,
                    color: Color.fromARGB(255, 152, 248, 72),
                  ),
                  Positioned(
                      left: width1*0.25,
                      top: height1*0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'aptak',
                            style: TextStyle(
                              fontSize: 70,
                              fontFamily: 'HappyMonkey',
                              color: Color.fromARGB(255, 152, 248, 72),
                            ),
                          ),
                          const Text(
                            'Welcome to the world of music',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                wordSpacing: 2),
                          )
                        ],
                      )),
                ]),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  } 

  Future<void> goToMyApp() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => MyMusicApp());
  }
}
   