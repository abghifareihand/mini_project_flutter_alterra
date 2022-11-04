import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/pages/review/review_list_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:mini_project_flutter_alterra/widgets/custom_button.dart';
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
      return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: secondColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: mainColor,
          ),
        ),
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
      return Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 256,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 24,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: whiteTextStyle.copyWith(
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
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
                                    onPressed: () =>
                                        provider.addFavorite(restaurant),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            restaurant.description,
                            style: blackTextStyle.copyWith(),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 24,
                                      color: mainColor,
                                    ),
                                    Text(
                                      restaurant.city,
                                      style: blackTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            title: 'Review',
                            width: 100,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReviewListPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
