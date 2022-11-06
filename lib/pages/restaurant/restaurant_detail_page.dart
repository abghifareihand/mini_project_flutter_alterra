import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/pages/favorite/favorite_update_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    Widget backButton() {
      return Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(defaultMargin),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: mainColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(defaultMargin),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: isFavorited
                        ? IconButton(
                            icon: const Icon(Icons.favorite),
                            color: Colors.redAccent,
                            onPressed: () =>
                                provider.deleteFavorite(restaurant.id),
                          )
                        : IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.redAccent,
                            onPressed: () {
                              provider.addFavorite(restaurant);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FavoriteUpdatePage(resto: restaurant),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    Widget backgroundImage() {
      return Hero(
        tag: restaurant.getMediumPicture(),
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                restaurant.getMediumPicture(),
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 300,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        restaurant.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                          Text(
                            restaurant.city,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            '${restaurant.rating}',
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Description :',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    restaurant.description,
                    style: blackTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                vertical: 30,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: lightBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage(),
              backButton(),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
