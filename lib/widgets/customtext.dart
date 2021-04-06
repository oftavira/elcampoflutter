import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomText({Key key, @required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: GoogleFonts.quicksand(
              fontSize: 20, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
