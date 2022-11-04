import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';

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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Account',
                style: orangeTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              ListTile(
                subtitle: Text(
                  'Edit Profile',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                subtitle: Text(
                  'Help',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'General',
                style: orangeTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              ListTile(
                subtitle: Text(
                  'Privacy & Policy',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                subtitle: Text(
                  'Term of Service',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                subtitle: Text(
                  'Rate App',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
