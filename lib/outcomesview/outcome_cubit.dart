import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/models/outcome_model.dart';

class OutcomeCubit extends Cubit<Outcome> {
  Outcome outcome;
  OutcomeCubit(Outcome outcome) : super(outcome);

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
    Outcome post = Outcome(state.items, state.date, state.folio, state.post);
    emit(post);
    refreshBill;
  }

  void addOutcome() {
    state.add('Jabon', 10);
    Outcome post = Outcome(state.items, state.date, state.folio, state.post);
    emit(post);
    refreshBill;
  }

  void increment() {
    state.add('Jabon', 10);
    Outcome post = Outcome(state.items, state.date, state.folio, state.post);
    emit(post);
  }

  void register(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("ventas/${state.ym}/outcomes")
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
          'Gasto registrado',
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
