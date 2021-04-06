import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/sales/row_designs.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class OutcomeStream extends StatelessWidget {
  final Date outcomeDate;
  const OutcomeStream({Key key, this.outcomeDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return StreamBuilder<DocumentSnapshot>(
      stream: context
          .cubit<FirebaseCubit>()
          .dayOutcomes(outcomeDate.ym, outcomeDate.ymd),
      builder: (context, salesStream) {
        if (salesStream.hasData) {
          List<Widget> ls = List<Widget>();
          Map<String, dynamic> content = salesStream.data.data();
          if (content == null || content.isEmpty) {
            ls = [
              Center(
                child: Text(
                  "Sin gastos este día",
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              )
            ];
          } else {
            content.forEach(
              (key, value) {
                ls.add(
                  OutcomeRow(
                    saleId: key,
                    details: value,
                    outcomeDate: outcomeDate,
                  ),
                );
              },
            );
          }
          return Container(
            child: Center(
              child: ListView.separated(
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (_, i) => ls[i],
                  separatorBuilder: (_, i) => Divider(height: 10),
                  itemCount: ls.length),
            ),
          );
        } else if (salesStream.hasError) {
          return Center(
            child: Text("Ocurrio un error, intente más tarde"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SalesStream extends StatelessWidget {
  final Date salesDate;
  const SalesStream({Key key, this.salesDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return StreamBuilder<DocumentSnapshot>(
      stream:
          context.cubit<FirebaseCubit>().daySales(salesDate.ym, salesDate.ymd),
      builder: (context, salesStream) {
        if (salesStream.hasData) {
          List<Widget> ls = List<Widget>();
          Map<String, dynamic> content = salesStream.data.data();
          if (content == null || content.isEmpty) {
            ls = [
              Center(
                child: Text(
                  "Sin ventas este día",
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              )
            ];
          } else {
            content.forEach((key, value) {
              ls.add(
                SalesRow(
                  saleId: key,
                  details: value,
                  saleDate: salesDate,
                ),
              );
            });
          }
          return Container(
            child: Center(
              child: ListView.separated(
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (_, i) => ls[i],
                  separatorBuilder: (_, i) => Divider(height: 10),
                  itemCount: ls.length),
            ),
          );
        } else if (salesStream.hasError) {
          return Center(
            child: Text("Ocurrio un error, intente más tarde"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
