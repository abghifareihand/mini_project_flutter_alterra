import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:mini_project_flutter_alterra/utils/result_state.dart';
import 'package:mini_project_flutter_alterra/widgets/restaurant_tile.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: const Text(
          'Favorite Page',
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.error) {
            return Center(
              child: Text(
                'No data favorite',
                style: orangeTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            );
          } else {
            return const RestaurantTile();
          }
        },
      ),
    );
  }
}
