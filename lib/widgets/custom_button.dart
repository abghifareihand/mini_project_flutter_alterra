import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/styles/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin; // untuk custom margin pada button

  const CustomButton({
    super.key,
    required this.title,
    this.width = double.infinity, // di kasih default agar bisa tanpa required
    required this.onPressed, // custom onPress navigaor jadi bisa ubah navigasi
    this.margin = EdgeInsets.zero, // custom margin di setiap button
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}