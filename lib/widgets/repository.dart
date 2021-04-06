import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';

List<DropdownMenuItem> MENU = strItems.keys
    .map(
      (key) => DropdownMenuItem(
        child: Container(
          child: Text(
            strItems[key],
            style:
                GoogleFonts.quicksand(color: TX1, fontWeight: FontWeight.w700),
          ),
        ),
        value: key,
      ),
    )
    .toList();

List<DropdownMenuItem> OUTCOMESMENU = strOutcomes.keys
    .map(
      (key) => DropdownMenuItem(
        child: Container(
          child: Text(
            strOutcomes[key],
            style:
                GoogleFonts.quicksand(color: TX1, fontWeight: FontWeight.w700),
          ),
        ),
        value: key,
      ),
    )
    .toList();

// List<DropdownMenuItem> menu = [
//   DropdownMenuItem(
//     child: Text("T. Enchilada",
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.w700)),
//     value: "TEnch",
//   ),
//   DropdownMenuItem(
//     child: Text("T. Longaniza",
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.w700)),
//     value: "TLong",
//   ),
//   DropdownMenuItem(
//     child: Text("T. Cecina",
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.w700)),
//     value: "TCec",
//   ),
//   DropdownMenuItem(
//     child: Text("T. Campechano",
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.w700)),
//     value: "TCamp",
//   ),
//   DropdownMenuItem(
//     child: Text("Refresco",
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.w700)),
//     value: "Refresc",
//   ),
// ];
