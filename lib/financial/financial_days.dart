import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/financial/financial_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/financial/financial_view.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/models/date_model.dart';

class DaysView extends StatelessWidget {
  final Date nowCheck;
  const DaysView({Key key, @required this.nowCheck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: EdgeInsets.all(5),

      // The Widget uses two stream builders, one that provides info about the
      // outcomes and other that provides sales info TODO: Improve readibility

      child: StreamBuilder(
          // This creates a stream of the
          stream: context
              .cubit<FirebaseCubit>()
              .monthOutcomes(context.cubit<FinancialCubit>().state.dateOR),
          builder: (context, outcomes) {
            return StreamBuilder(
              stream: context
                  .cubit<FirebaseCubit>()
                  .monthSales(context.cubit<FinancialCubit>().state.dateOR),
              builder: (context, sales) {
                Map<String, Map> daysCheck = {};
                List<Widget> daysList = [];
                if (sales.hasData && outcomes.hasData) {
                  double total = 0;
                  double outcome = 0;
                  // TODO: Change this to a non build method so it can´t affect
                  // the refreshing time of the screen

                  for (Iterator<QueryDocumentSnapshot> it =
                          outcomes.data.docs.iterator;
                      it.moveNext();) {
                    // print('Prt the data on the current OUTCOMEEES \n');
                    // print(it.current.data());

                    it.current.data().forEach((key, value) {
                      outcome += value['total'];
                    });

                    // print('Ending total OUTCOMES with...\n');
                    // print(total.toString());
                    // print(context.cubit<FinancialCubit>().state.dateOR.ym);

                    // print('*** Ending printing *** \n');
                    daysCheck.putIfAbsent(
                      it.current.id,
                      () => it.current.data(),
                    );
                  }

                  // TODO

                  for (Iterator<QueryDocumentSnapshot> it =
                          sales.data.docs.iterator;
                      it.moveNext();) {
                    // print(
                    //     'Prt the data on the current QueryDocumentSnapshot \n');
                    // print(it.current.data());

                    it.current.data().forEach((key, value) {
                      total += value['total'];
                    });

                    daysCheck.putIfAbsent(
                      it.current.id,
                      () => it.current.data(),
                    );
                  }

                  print('\n \n Total $total Outcome $outcome \n \n');

                  FirebaseFirestore db = FirebaseFirestore.instance;
                  db
                      .collection("ventas")
                      .doc("${context.cubit<FinancialCubit>().state.dateOR.ym}")
                      .set(
                    {
                      'total': total,
                      'outcome': outcome,
                    },
                    SetOptions(merge: true),
                  );
                  for (Iterator<QueryDocumentSnapshot> it =
                          outcomes.data.docs.iterator;
                      it.moveNext();) {
                    daysCheck.putIfAbsent(
                        it.current.id, () => it.current.data());
                  }
                  daysCheck.keys.toList()
                    ..sort()
                    ..forEach((element) {
                      daysList.add(
                        DayFinance(element, daysCheck[element], nowCheck),
                      );
                    });
                  return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return daysList[i];
                      },
                      separatorBuilder: (_, i) => SizedBox(width: 10),
                      itemCount: daysList.length);
                } else {
                  // TODO: Maybe change this with a shimer

                  return CircularProgressIndicator();
                }
              },
            );
          }),
      decoration: BoxDecoration(
        color: PR2,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }
}
