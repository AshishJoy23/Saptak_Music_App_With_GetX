import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:saptak_music_app/view/screens/settings/widgets/about_dialog_widget.dart';
import 'package:saptak_music_app/view/screens/settings/widgets/privacy_policy.dart';
import 'package:saptak_music_app/view/screens/settings/widgets/settings_list_tile.dart';
import 'package:saptak_music_app/view/screens/settings/widgets/terms_and_condtn.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0, bottom: 8.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFF00010A).toMaterialColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: const Text(
                'Theme',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SettingsListTileWidget(
            title: "Privacy Policy",
            onPressedPage: PrivacyPolicy(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SettingsListTileWidget(
            title: "Terms and Conditions",
            onPressedPage: TermsAndCondition(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SettingsListTileWidget(
            title: "About Us",
            onPressedPage: AboutDialogWidget(),
          ),
        ]),
      ),
    );
  }
}

