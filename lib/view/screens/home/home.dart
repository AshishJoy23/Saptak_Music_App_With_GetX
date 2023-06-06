import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/home_controller.dart';
import 'package:saptak_music_app/view/screens/home/widgets/home_main_button.dart';
import 'package:saptak_music_app/view/screens/search/search_screen.dart';
import 'package:saptak_music_app/view/screens/home/widgets/allsongs_list.dart';

class ScreenHome extends StatelessWidget {
  //final String title;
  const ScreenHome({super.key});

  //List<MostlyPlayed> mostlySongs = [];
  //var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: widthDsp * 0.03),
          child: const CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage('assets/images/saptak_icon.png'),
          ),
        ),
        title: Obx(
          () => Text(
            (homeController.time.value.hour < 12)
                ? 'Good Morning!'
                : ((homeController.time.value.hour < 17) 
                ? 'Good Afternoon!' 
                : 'Good Evening!'),
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'HappyMonkey',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const ScreenSearch());
            },
            icon: const Icon(Icons.search_sharp,
                size: 28, color: Color.fromARGB(255, 152, 248, 72)),
          ),
          SizedBox(
            width: widthDsp * 0.02,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: widthDsp * 0.025,
            right: widthDsp * 0.025,
            top: heightDsp * 0.01),
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Discover!',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightDsp * 0.008,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      HomeMainButtonWidget(title: 'Recently Played',),
                      HomeMainButtonWidget(title: 'Mostly Played',),
                    ],
                  ),
                  SizedBox(
                    height: heightDsp * 0.007,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Find Your Music',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.3,
                    color: Colors.white,
                  ),
                  // const ScreenAllSongs(),
                ],
              ),
              const ScreenAllSongs(),
            ],
          ),
        ),
      ),
    );
  }
}

