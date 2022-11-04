import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/review_model.dart';
import 'package:mini_project_flutter_alterra/providers/database_provider.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';
import 'package:provider/provider.dart';

class ReviewAddUpdatePage extends StatefulWidget {
  final ReviewModel? review;

  const ReviewAddUpdatePage({Key? key, this.review}) : super(key: key);

  @override
  State<ReviewAddUpdatePage> createState() => _ReviewAddUpdatePageState();
}

class _ReviewAddUpdatePageState extends State<ReviewAddUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.review != null) {
      _nameController.text = widget.review!.nameResto;
      _descController.text = widget.review!.descResto;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: mainColor),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  label: const Text('Restaurant Name'),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _descController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  label: const Text('Restaurant Review'),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Simpan'),
                onPressed: () async {
                  if (!_isUpdate) {
                    final review = ReviewModel(
                      nameResto: _nameController.text,
                      descResto: _descController.text,
                    );

                    Provider.of<DatabaseProvider>(context, listen: false)
                        .addReview(review);
                  } else {
                    final review = ReviewModel(
                      id: widget.review!.id,
                      nameResto: _nameController.text,
                      descResto: _descController.text,
                    );

                    Provider.of<DatabaseProvider>(context, listen: false)
                        .updateReview(review);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
