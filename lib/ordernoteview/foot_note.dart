import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/ordernoteview/order_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class Billing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: PR2),
            child: IconButton(
              icon: Icon(Icons.check, color: TX1),
              onPressed: () {
                if (context.cubit<OrderCubit>().state.bill != 0) {
                  HapticFeedback.mediumImpact();
                  context.cubit<OrderCubit>().register(context);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        'Enviando registro...',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: PR2)),
            child: Center(
              child: StreamBuilder<double>(
                initialData: 0,
                stream: context.cubit<OrderCubit>().cStream,
                builder: (_, snapshot) {
                  // TODO Move this to the cubitLogic
                  context.cubit<OrderCubit>().refreshBill;
                  String _pre = snapshot.data.toStringAsFixed(1);
                  return Text(
                    '\$ ' + _pre,
                    style: GoogleFonts.quicksand(
                        color: TX1, fontWeight: FontWeight.w700, fontSize: 25),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
