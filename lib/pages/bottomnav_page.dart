import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mini_project_flutter_alterra/pages/favorite_page.dart';
import 'package:mini_project_flutter_alterra/pages/restaurant_page.dart';
import 'package:mini_project_flutter_alterra/pages/setting_page.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';

class BottomnavPage extends StatefulWidget {
  const BottomnavPage({super.key});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {
  int _selectedIndex = 0;
  List pages = [
    const RestaurantPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: pages[_selectedIndex],
    );
  }

  Widget bottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          color: greyColor,
          activeColor: mainColor,
          tabBackgroundColor: secondColor,
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.restaurant_menu,
              text: 'Restaurant',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
