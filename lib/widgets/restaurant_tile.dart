import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mini_project_flutter_alterra/pages/favorite/favorite_update_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        final ulasan = provider.favorite;
        return ListView.builder(
          itemCount: ulasan.length,
          itemBuilder: (context, index) {
            final ulas = ulasan[index];
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.25,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    backgroundColor: Colors.redAccent,
                    icon: Icons.delete,
                    label: 'Delete',
                    onPressed: (context) => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        title: const Text('Delete'),
                        content: Text(
                            'Delete ${ulas.name} from review and list favorite?'),
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
                              return provider.deleteFavorite(ulas.id);
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
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FavoriteUpdatePage(resto: ulas),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween(
                          begin: const Offset(1, 0),
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
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ulas.name,
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${ulas.rating}',
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.red,
                          ),
                          Text(
                            ulas.city,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        ulas.review ?? '',
                        style: greyTextStyle.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
