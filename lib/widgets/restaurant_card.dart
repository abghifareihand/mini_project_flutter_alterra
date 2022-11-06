import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/pages/favorite/favorite_update_page.dart';
import 'package:mini_project_flutter_alterra/pages/restaurant/restaurant_detail_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantDetailPage(restaurant: restaurant),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final tween = Tween(
                              begin: const Offset(0, 1),
                              end: Offset.zero,
                            );
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: restaurant.name,
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              restaurant.getMediumPicture(),
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.8,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: isFavorited
                                      ? IconButton(
                                          icon: const Icon(Icons.favorite),
                                          color: Colors.redAccent,
                                          onPressed: () => provider
                                              .deleteFavorite(restaurant.id),
                                        )
                                      : IconButton(
                                          icon:
                                              const Icon(Icons.favorite_border),
                                          color: Colors.redAccent,
                                          onPressed: () {
                                            provider.addFavorite(restaurant);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FavoriteUpdatePage(
                                                        resto: restaurant),
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 22,
                      ),
                      Text(
                        '${restaurant.rating}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
