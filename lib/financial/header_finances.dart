import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/financial/financial_cubit.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/widgets/customtext.dart';

class HeaderBackground extends StatelessWidget {
  final ScrollController controller;
  final List<Widget> widgetMonths;
  const HeaderBackground(
      {@required this.controller, @required this.widgetMonths, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.cubit<FirebaseCubit>().checkMonth(Date()),
      builder: (context, qSnapshot) {
        if (qSnapshot.hasData) {
          // Checking if the list of widgets that contain
          // info about the month is empty, if true, this constructs
          // the widgets
          if (widgetMonths.isEmpty) {
            for (Iterator<QueryDocumentSnapshot> it =
                    qSnapshot.data.docs.iterator;
                it.moveNext();) {
              widgetMonths.add(
                MonthFinance(
                  it.current.id,
                  it.current.data(),
                ),
              );
            }
          }
          // Container that displays the Day Info Month/Day
          return Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    return widgetMonths[i];
                  },
                  separatorBuilder: (i, c) => SizedBox(
                    width: 10,
                  ),
                  itemCount: widgetMonths.length,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: TRW,
              borderRadius: BorderRadius.circular(25),
            ),
          );
        } else if (qSnapshot.hasError) {
          return Container(color: CN1);
        } else {
          return Container(
            decoration: BoxDecoration(
              color: TRW,
              borderRadius: BorderRadius.circular(25),
            ),
          );
        }
      },
    );
  }
}

// docs.forEach((doc) {
//   monthsList.add(
//     MonthFinance(
//       doc.id,
//     ),
//   );
// });

// A design that shows money-info about a month
// Aspect: Rectangular blue box with Year-Month as Title
//
// TODO add the name of the month, add the total amount of income/outcome

class MonthFinance extends StatelessWidget {
  final String content;
  final Map data;
  const MonthFinance(this.content, this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Setting the finances info on the selected month
        context.cubit<FinancialCubit>().setFinancesOn(content);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: PR2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: content.split('-')[0],
              color: Colors.white,
            ),
            CustomText(
              text: Date.fromMonth(content).monthName(),
              color: Colors.green[800],
            ),
            CustomText(
              text: '\$' + data['total'].toStringAsFixed(2),
              color: Colors.lightGreenAccent[100],
            ),
            CustomText(
              text: '\$' + data['outcome'].toStringAsFixed(2),
              color: Colors.orange[600],
            ),
          ],
        ),
      ),
    );
  }
}
