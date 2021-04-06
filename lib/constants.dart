import 'package:flutter/material.dart';

// #5E99C2#7DF9C2#3FC08D#008A5A

Color PR1 = const Color(0xFFD14568);
Color CN1 = Colors.greenAccent[700];
Color CN1S = const Color(0xFF849A00);
Color CN2 = const Color(0xFF1B48B8);
Color TRCN2 = const Color(0xCF1B48B8);
Color TX1 = const Color(0xFFFFFFFF);
Color TX2 = const Color(0xFF534439);
Color TRTX2 = const Color(0xCF534439);
Color TX3 = const Color(0xFFCCCCCC);
Color PR2 = const Color(0xFF33B0D7);
Color TCN1 = const Color(0xFF00C55C);

// Color PR2 = const Color(0xFFFF9455);
// Color GR1 = const Color(0XFF534439);
// Color GR2 = const Color(0xFFAAA89B);

Color TRPR2 = const Color(0x9F33B0D7);

Color TPR1 = const Color(0xAFFF8800);
Color TPR2 = const Color(0xAFFF9455);
Color TCN2 = const Color(0xAFA78BFF);
Color TGR1 = const Color(0XAF534439);
Color TGR2 = const Color(0xAFBAA89B);

Color TR = const Color(0x00000000);
Color TRW = const Color(0x2FFFFFFF);

Map<int, String> months = {
  1: "enero",
  2: "febrero",
  3: "marzo",
  4: "abril",
  5: "mayo",
  6: "junio",
  7: "julio",
  8: "agosto",
  9: "septiembre",
  10: "octubre",
  11: "noviembre",
  12: "diciembre"
};

Map<String, double> price = {
  "Ropa": 1.4,
  "Cobija": 1,
  "Edredon": 1,
  "Tintoreria": 1,
  "Tenis": 1,
  "Tapete": 1,
  "Otro": 1,
};

Map<String, String> strItems = {
  "Ropa": "Ropa (kg)",
  "Cobija": "Cobija",
  "Edredon": "Edredón",
  "Tintoreria": "Tintorería",
  "Tenis": "Tenis",
  "Tapete": "Tapete",
  "Otro": "Otro",
};

Map<String, String> strOutcomes = {
  "Gas": "Gas",
  "Auto": "Auto",
  "Servicio": "Servicio",
  "Jabon": "Jabon",
  "Luz": "Luz",
  "Agua": "Agua",
  "Tintoreria": "Tinto."
};

Map<String, double> outcomePrice = {
  "Gas": 1,
  "Auto": 1,
  "Servicio": 1,
  "Jabon": 1,
  "Luz": 1,
  "Agua": 1,
  "Tintoreria": 1
};

List<String> ROUTES = [
  'Nota./nota',
  'Gastos./gastos',
  'Ventas./ventas',
  'Finanzas./finanzas',
];
