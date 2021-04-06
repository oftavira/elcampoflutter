import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/models/sale_model.dart';

class OrderCubit extends Cubit<Sale> {
  Sale sale;
  OrderCubit(Sale sale) : super(sale);

  StreamController<double> billStream = StreamController<double>.broadcast();
  Stream<double> get cStream => billStream.stream;
  void get refreshBill => billStream.add(state.bill);

  void minusAt(int n, int x) {
    state.minusAt(n, x);
    refreshBill;
  }

  void plusAt(int n, int x) {
    state.plusAt(n, x);
    refreshBill;
  }

  void addE(String element, int count) {
    state.add(element, count);
    refreshBill;
  }

  void delAt(int i) {
    state.removeAt(i);
    Sale post = Sale(state.items, state.date, state.folio, state.post);
    emit(post);
    refreshBill;
  }

  void increment() {
    state.add('Ropa', 10);
    Sale post = Sale(state.items, state.date, state.folio, state.post);
    emit(post);
  }

  void checkFol() {
    state.folio == null ? state.folio = 0 : null;
  }

  void register(BuildContext context) {
    checkFol();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("ventas/${state.ym}/days")
        .doc("${state.ymd}")
        .set(
          {
            state.strId: {
              "status": true,
              "items": state.items.toString(),
              "total": state.bill,
              "post": state.post,
            }
          },
          SetOptions(merge: true),
        )
        .then((v) => notified(context))
        .catchError((e) => print('Error en la escritura ${e.toString()}'));
  }

  void notified(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Venta registrada',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  dispose() {
    print('\n \n \n');
    print('Disposing streams');
    print('\n \n \n');
    billStream.close();
  }
}
