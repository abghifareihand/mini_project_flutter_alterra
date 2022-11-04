import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/pages/restaurant_detail_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class RestaurantTile extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RestaurantDetailPage(restaurant: restaurant),
                    ),
                  );
                },
                child: Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(20),
                        backgroundColor: Colors.redAccent,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) =>
                            provider.deleteFavorite(restaurant.id),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 16,
                      right: 16,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: NetworkImage(
                                restaurant.getSmallPicture(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: medium,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: mainColor,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultRadius),
                              ),
                              title: const Text('Delete'),
                              content: Text(
                                  'Delete ${restaurant.name} list favorite?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: orangeTextStyle.copyWith(
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    return provider
                                        .deleteFavorite(restaurant.id);
                                  },
                                  child: Text(
                                    'OK',
                                    style: orangeTextStyle.copyWith(
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
