import 'package:flutter/material.dart';
import 'package:vadmin/accounts/accounts.dart';
import 'package:vadmin/financial/financial_view.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/models/sale_model.dart';
import 'package:vadmin/outcomesview/outcomes_view.dart';
import 'package:vadmin/sales/sales.dart';
import 'package:vadmin/ordernoteview/note_view.dart';
import 'package:vadmin/search_tool/search.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/nota':
      return MaterialPageRoute(
        builder: (_) => OrderNote(
          sale: Sale(),
        ),
      );

    case '/gastos':
      return MaterialPageRoute(
        builder: (_) => OutcomesView(
          outcome: Outcome(),
        ),
      );

    case '/ventaendia':
      return MaterialPageRoute(
        builder: (_) => OrderNote(
          sale: settings.arguments,
        ),
      );

    case '/gastoendia':
      return MaterialPageRoute(
        builder: (_) => OutcomesView(
          outcome: settings.arguments,
        ),
      );

    case '/ventas':
      return MaterialPageRoute(
        builder: (_) => SalesView(
          Date(),
        ),
      );

    case '/finanzas':
      return MaterialPageRoute(
        builder: (_) => FinancialView(
          now: Date(),
        ),
      );

    case '/editcomanda':
      return MaterialPageRoute(
        builder: (_) {
          return OrderNote(
            sale: settings.arguments,
          );
        },
      );

    case '/verdia':
      return MaterialPageRoute(
        builder: (_) {
          return SalesView(
            settings.arguments,
          );
        },
      );

    case '/busqueda':
      return MaterialPageRoute(
        builder: (_) => SearchBox(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => OrderNote(
          sale: Sale(),
        ),
      );
  }
}
