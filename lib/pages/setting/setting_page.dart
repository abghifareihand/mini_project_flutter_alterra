import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:mini_project_flutter_alterra/widgets/profile_menu.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: const [
            SizedBox(
              height: 120,
              width: 120,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.png'),
                child: Icon(Icons.camera_alt),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ProfileMenu(
              text: 'My Account',
            ),
            ProfileMenu(
              text: 'Notifications',
            ),
            ProfileMenu(
              text: 'Help Center',
            ),
            ProfileMenu(
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
