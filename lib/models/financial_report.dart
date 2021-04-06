import 'package:vadmin/models/date_model.dart';

class FinancialReport {
  Date dateOR;

  FinancialReport({this.dateOR}) {
    this.dateOR ??= Date();
  }

  String getDay() {
    return this.dateOR.ym;
  }
}
