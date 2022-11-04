import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/main.dart';
import 'package:mini_project_flutter_alterra/pages/review/review_add_update_page.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Review All Restaurant'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          final reviews = provider.review;
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                child: ListTile(
                  title: Text(review.nameResto),
                  subtitle: Text(review.descResto),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    final selectedNote =
                        await provider.getReviewById(review.id!);
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ReviewAddUpdatePage(
                            review: selectedNote,
                          );
                        },
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: mainColor,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        title: const Text('Delete'),
                        content: const Text('Delete review restaurant?'),
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
                              return provider.deleteReview(review.id!);
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
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ReviewAddUpdatePage()),
          );
        },
      ),
    );
  }
}
