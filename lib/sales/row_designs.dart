import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/models/sale_model.dart';
import 'package:vadmin/services/locator.dart';
import 'package:vadmin/services/navigationservice.dart';
import 'package:vadmin/widgets/customtext.dart';
import 'package:vadmin/constants.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class OutcomeRow extends StatelessWidget {
  final String saleId;
  final Map details;
  final Date outcomeDate;
  const OutcomeRow(
      {Key key,
      @required this.saleId,
      @required this.details,
      @required this.outcomeDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic ref = details['post'];
    ref ??= ' ';
    Outcome currentOutcome = Outcome.fromStr(details, saleId);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ExpansionTile(
        trailing: Icon(Icons.arrow_drop_down, color: PR1),
        leading: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              HapticFeedback.mediumImpact();
              context
                  .cubit<FirebaseCubit>()
                  .state
                  .db
                  .collection("ventas/${outcomeDate.ym}/outcomes")
                  .doc(outcomeDate.day)
                  .update({saleId: FieldValue.delete()});
            }),
        title: CustomText(text: currentOutcome.hourfolio, color: Colors.white),
        subtitle: Column(
          children: [
            CustomText(
              color: Colors.green,
              text: '\$ ' + currentOutcome.billStr,
            ),
            CustomText(color: Colors.white, text: ref),
          ],
        ),
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currentOutcome.items.length,
              itemBuilder: (_, i) => CustomText(
                  color: Colors.white,
                  text: strOutcomes[currentOutcome.items[i][0].toString()] +
                      "   " +
                      currentOutcome.items[i][1].toString()),
            ),
          ),
          SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PR1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    locator<NavigationService>()
                        .navigateO('/gastoendia', currentOutcome);
                  },
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

class SalesRow extends StatelessWidget {
  final String saleId;
  final Map details;
  final Date saleDate;
  const SalesRow(
      {Key key,
      @required this.saleId,
      @required this.details,
      @required this.saleDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic ref = details['post'];
    ref ??= ' ';
    Sale currentSale = Sale.fromStr(details, saleId);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent[700],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ExpansionTile(
        trailing: Icon(Icons.arrow_drop_down, color: PR1),
        leading: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              HapticFeedback.mediumImpact();
              context
                  .cubit<FirebaseCubit>()
                  .state
                  .db
                  .collection("ventas/${saleDate.ym}/days")
                  .doc(saleDate.day)
                  .update({saleId: FieldValue.delete()});
            }),
        title: CustomText(text: currentSale.hourfolio, color: Colors.white),
        subtitle: Column(
          children: [
            CustomText(
              color: Colors.green[300],
              text: '\$ ' + currentSale.billStr,
            ),
            CustomText(
              color: Colors.white,
              text: ref,
            )
          ],
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent[400],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currentSale.items.length,
              itemBuilder: (_, i) => CustomText(
                  color: Colors.white,
                  text: strItems[currentSale.items[i][0].toString()] +
                      "   " +
                      currentSale.items[i][1].toString()),
            ),
          ),
          SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PR1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    locator<NavigationService>()
                        .navigateS('/editcomanda', currentSale);
                  },
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
