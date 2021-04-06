import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vadmin/constants.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/financial/financial_cubit.dart';
import 'package:vadmin/financial/financial_days.dart';
import 'package:vadmin/financial/header_finances.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/models/financial_report.dart';
import 'package:vadmin/services/locator.dart';
import 'package:vadmin/services/navigationservice.dart';
import 'package:vadmin/widgets/customtext.dart';

class FinancialView extends StatelessWidget {
  final Date now;
  const FinancialView({
    Key key,
    @required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Whole container
    return CubitProvider(
      create: (_) => FinancialCubit(
        report: FinancialReport(),
      ),
      child: CubitBuilder<FinancialCubit, FinancialReport>(
        builder: (context, state) {
          return Container(
            child: Stack(
              children: [
                // Decoration background
                BackGroundDecoration(),
                // Main Content of this view
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Scrollable header items with month-money info
                      // Flex : 4/14
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          child: HeaderBackground(
                            controller: ScrollController(),
                            widgetMonths: List<Widget>(),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: TRW),
                        ),
                      ),
                      SizedBox(height: 10),
                      // QuickView of current month-money state
                      // like total spent,
                      // Flex : 3/14
                      Expanded(
                        flex: 3,
                        child: DaysView(
                          nowCheck: now,
                        ),
                      ),
                      SizedBox(height: 10),
                      // A register section for spent money
                      // Flex : 7/14
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CN2,
                            border: Border.all(color: TX1),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                          // child: Center(child: Outcomes()),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );

    // This GestureDetector wraps the entire view to enable unfocus behaviour
    // triggered if other field that is non editable is tapped
  }
}

class BackGroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [CN2, CN1],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: CN2,
          ),
        )
      ],
    );
  }
}

class DayFinance extends StatelessWidget {
  final Date now;
  final String content;
  final Map<String, dynamic> data;
  const DayFinance(this.content, this.data, this.now, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Date test = Date.fromDay(content, now);
        locator<NavigationService>().navigateSD(
          '/verdia',
          Date.fromDay(content, now),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CN2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: Date.fromDay(content, now).monthName(),
              color: TX1,
            ),
            CustomText(
              text: Date.fromDay(content, now).dayName() +
                  ' ' +
                  content.split('-')[2],
              color: TX3,
            ),
          ],
        ),
      ),
    );
  }
}
