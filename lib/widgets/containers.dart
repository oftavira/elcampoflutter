import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 20,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: [TCN2, TCN1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: TR,
          border: Border.all(color: TX1),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(5),
        child: RowItemInfo(),
      ),
    );
  }
}

class RowItemInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: TX1),
            borderRadius: BorderRadius.circular(30),
          ),
          width: MediaQuery.of(context).size.width / 3,
          //TODO Ad child : image
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: ColumnItemInfo(title: null, info: null, price: null),
        )
      ],
    );
  }
}

class ColumnItemInfo extends StatelessWidget {
  final String title;
  final String info;
  final String price;
  ColumnItemInfo(
      {@required this.title, @required this.info, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: TX1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MText(
            cont: 'Title of the Item',
            fontw: FontWeight.w700,
          ),
          MText(
            cont: 'Real Content',
            fontw: FontWeight.w500,
          ),
          MText(
            cont: 'details',
            fontw: FontWeight.w800,
          )
        ],
      ),
    );
  }
}

class MText extends StatelessWidget {
  final String cont;
  final FontWeight fontw;
  const MText({Key key, @required this.cont, this.fontw}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(cont,
          style: GoogleFonts.quicksand(
            fontWeight: fontw,
            color: TX1,
          )),
    );
  }
}
