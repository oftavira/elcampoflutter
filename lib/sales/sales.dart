import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/models/sale_model.dart';
import 'package:vadmin/sales/sales_view.dart';
import 'package:vadmin/services/locator.dart';
import 'package:vadmin/services/navigationservice.dart';
import 'package:vadmin/sized_widget/sized_widget.dart';
import 'package:vadmin/widgets/customtext.dart';
import 'package:vadmin/widgets/notedecorator.dart';

// Stateful Widget is used to provide screen refresh when neeed it
// this is a view of the active sales, this means that the subfield
// 'active' must be true.

// TODO.
// Change this to a const widget

class SalesView extends StatelessWidget {
  final Date date;
  SalesView(this.date);

  @override
  Widget build(BuildContext context) {
    return NoteDecorator(
      r: 0,
      chld: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40,
            child: CustomText(text: date.casualDate(), color: Colors.white),
          ),
          Expanded(
            child: SizedWidget(
              theBuilder: (context, sizingInformation) {
                return Contenido(
                  date: date,
                  availableHeight: sizingInformation.widgetSize.height,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Contenido extends StatelessWidget {
  final double availableHeight;
  final Date date;
  const Contenido({Key key, @required this.availableHeight, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SalesBody(
        date: date,
        aH: availableHeight,
      ),
    );
  }
}

class SalesBody extends StatefulWidget {
  final double aH;
  final Date date;
  SalesBody({Key key, this.aH, this.date}) : super(key: key);

  @override
  _SalesBodyState createState() => _SalesBodyState();
}

class _SalesBodyState extends State<SalesBody> {
  double aH;
  double factor;

  @override
  void initState() {
    aH = widget.aH - 40;
    factor = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                fit: StackFit.passthrough,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: 1 - factor,
                    child: CustomText(text: 'Ventas', color: Colors.white),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: factor,
                    child: CustomText(text: 'Gastos', color: Colors.white),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  factor = 1 - factor;
                  setState(() {});
                },
                color: PR2,
                child: Icon(Icons.cached, color: Colors.white),
              ),
              RaisedButton(
                onPressed: () {
                  factor == 0
                      ? HapticFeedback.mediumImpact().then((value) {
                          locator<NavigationService>().navigateS(
                            '/ventaendia',
                            Sale.fromDate(widget.date),
                          );
                        })
                      : HapticFeedback.mediumImpact().then((value) {
                          locator<NavigationService>().navigateO(
                            '/gastoendia',
                            Outcome.fromDate(widget.date),
                          );
                        });
                },
                color: PR2,
                child: Icon(Icons.add_box_sharp, color: Colors.white),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          color: TRCN2,
          height: aH * (1 - factor),
          duration: Duration(milliseconds: 600),
          child: SalesStream(
            salesDate: widget.date,
          ),
        ),
        AnimatedContainer(
          color: TRTX2,
          height: aH * factor,
          duration: Duration(milliseconds: 600),
          child: OutcomeStream(
            outcomeDate: widget.date,
          ),
        ),
      ],
    );
  }
}

// Container(
//             color: Colors.blueAccent[700],
//             height: 40,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomText(
//                   text: 'Ventas',
//                   color: Colors.white,
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     HapticFeedback.mediumImpact();
//                     locator<NavigationService>().navigateS(
//                       '/ventaendia',
//                       Sale.fromDate(this.date),
//                     );
//                   },
//                   child: Icon(
//                     Icons.add_circle_outlined,
//                     color: Colors.white,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.blueAccent[700],
//                 ),
//               ),
//               padding: EdgeInsets.all(5),
//               child: SalesStream(
//                 salesDate: date,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.grey[800],
//             height: 40,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomText(
//                   text: 'Gastos',
//                   color: Colors.white,
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     HapticFeedback.mediumImpact();
//                     locator<NavigationService>().navigateO(
//                       '/gastoendia',
//                       Outcome.fromDate(this.date),
//                     );
//                   },
//                   child: Icon(
//                     Icons.add_circle_outlined,
//                     color: Colors.white,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration:
//                   BoxDecoration(border: Border.all(color: Colors.grey[800])),
//               padding: EdgeInsets.all(5),
//               child: OutcomeStream(
//                 outcomeDate: date,
//               ),
//             ),
//           )
