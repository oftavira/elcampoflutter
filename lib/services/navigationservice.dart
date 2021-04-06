import 'package:flutter/material.dart';
import 'package:vadmin/models/date_model.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/models/sale_model.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateS(String routeName, Sale sale) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: sale);
  }

  Future<dynamic> navigateO(String routeName, Outcome outcome) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: outcome);
  }

  Future<dynamic> navigateSD(String routeName, Date date) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: date);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
