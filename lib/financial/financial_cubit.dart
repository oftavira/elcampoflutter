import 'package:cubit/cubit.dart';
import 'package:vadmin/models/financial_report.dart';
import 'package:vadmin/models/date_model.dart';

class FinancialCubit extends Cubit<FinancialReport> {
  FinancialReport report;
  FinancialCubit({this.report}) : super(report) {
    this.report ??= FinancialReport();
  }
  void setFinancesOn(String newDate) {
    Date n = Date.fromMonth(newDate);
    FinancialReport newState = FinancialReport(dateOR: n);
    emit(newState);
  }
}
