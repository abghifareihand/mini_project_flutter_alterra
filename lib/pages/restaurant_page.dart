import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/main.dart';
import 'package:mini_project_flutter_alterra/providers/restaurant_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:mini_project_flutter_alterra/utils/result_state.dart';
import 'package:mini_project_flutter_alterra/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).getAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Restaurant List',
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          } else if (provider.state == ResultState.error) {
            return Center(
              child: Column(
                children: const [
                  Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4,
                    color: Colors.redAccent,
                    size: 100,
                  ),
                  Text(
                    'Check your internet !!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.restaurant.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: provider.restaurant[index]);
              },
            );
          }
        },
      ),
    );
  }
}
