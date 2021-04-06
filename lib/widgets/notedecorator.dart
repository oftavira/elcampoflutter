import 'package:flutter/material.dart';
import 'package:vadmin/constants.dart';

class NoteDecorator extends StatelessWidget {
  final Widget chld;
  final double r;
  const NoteDecorator({Key key, this.chld, @required this.r}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [CN2, CN1])),
      padding: EdgeInsets.all(5),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(r), color: TRW),
        child: chld,
      ),
    );
  }
}
