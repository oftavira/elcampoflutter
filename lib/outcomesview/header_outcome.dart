import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/outcomesview/outcome_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class HeaderOutcome extends StatelessWidget {
  const HeaderOutcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.cubit<OutcomeCubit>().addOutcome();
        print('${context.cubit<OutcomeCubit>().state.post}');
      },
      child: Column(
        children: [
          Container(
            height: 50,
            width: 150,
            child: Icon(
              Icons.monetization_on_outlined,
              color: TX1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: PR2,
            ),
          ),
          PostData(
            initial: TextEditingController(
                text: context.cubit<OutcomeCubit>().state.post),
          )
        ],
      ),
    );
  }
}

class PostData extends StatefulWidget {
  final TextEditingController initial;
  PostData({Key key, this.initial}) : super(key: key);

  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final TextEditingController postData = TextEditingController();
  final lettersPat = RegExp(r'[a-z]');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PR2),
      ),
      height: 50,
      child: Center(
        child: TextFormField(
          style: GoogleFonts.quicksand(color: TX1, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
              errorStyle: GoogleFonts.quicksand(
                  color: TX2, fontWeight: FontWeight.w500),
              hintStyle: GoogleFonts.quicksand(
                  color: TX2, fontWeight: FontWeight.w500),
              hintText: 'Observaciones'),
          autovalidateMode: AutovalidateMode.always,
          controller: widget.initial,
          // TODO: Check if a validation is needed
          validator: (value) {
            if (value.isEmpty) {
              return 'Ingrese una nota de gastos';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // pattern.hasMatch checks for non digits in this field
            // the field
            if (lettersPat.hasMatch(value) && value.isNotEmpty) {
              context.cubit<OutcomeCubit>().state.setPost(value);
            }
          },
        ),
      ),
    );
  }
}
