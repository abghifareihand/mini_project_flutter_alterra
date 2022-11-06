import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class FavoriteUpdatePage extends StatefulWidget {
  final RestaurantModel? resto;

  const FavoriteUpdatePage({Key? key, this.resto}) : super(key: key);

  @override
  State<FavoriteUpdatePage> createState() => _FavoriteUpdatePageState();
}

class _FavoriteUpdatePageState extends State<FavoriteUpdatePage> {
  final TextEditingController _reviewController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.resto != null) {
      _reviewController.text = widget.resto!.review ?? '';
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBgColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Form Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant ${widget.resto!.name}',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _reviewController,
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Review something here...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
              ),
              style: blackTextStyle.copyWith(),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: const Text('Simpan'),
                onPressed: () async {
                  if (!_isUpdate) {
                    final resto = RestaurantModel(
                      id: widget.resto!.id,
                      name: '',
                      description: '',
                      pictureId: '',
                      city: '',
                      rating: 0,
                      review: _reviewController.text,
                    );

                    Provider.of<DatabaseProvider>(context, listen: false)
                        .addFavorite(resto);
                  } else {
                    final resto = RestaurantModel(
                      id: widget.resto!.id,
                      name: widget.resto!.name,
                      description: '',
                      pictureId: '',
                      city: widget.resto!.city,
                      rating: widget.resto!.rating,
                      review: _reviewController.text,
                    );

                    Provider.of<DatabaseProvider>(context, listen: false)
                        .updateFavorite(resto);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
