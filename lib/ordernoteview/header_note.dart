import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/ordernoteview/order_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class HeaderNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String folio = '';
    if (context.cubit<OrderCubit>().state.folio != null) {
      String folio = context.cubit<OrderCubit>().state.folio.toString();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SetFolio(
              initial: TextEditingController(
                text: folio,
              ),
            ),
            AddRow(),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: PostData(
            initial: TextEditingController(
              text: context.cubit<OrderCubit>().state.post,
            ),
          ),
        ),
      ],
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
  final lettersPat = RegExp(r'[a-z]');
  @override
  Widget build(BuildContext context) {
    print(context.cubit<OrderCubit>().state.post);
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
              return 'Ingrese una nota';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // pattern.hasMatch checks for non digits in this field
            // the field
            if (lettersPat.hasMatch(value) && value.isNotEmpty) {
              context.cubit<OrderCubit>().state.setPost(value);
            }
          },
        ),
      ),
    );
  }
}

class SetFolio extends StatefulWidget {
  final TextEditingController initial;
  SetFolio({Key key, this.initial}) : super(key: key);

  @override
  _SetFolioState createState() => _SetFolioState();
}

class _SetFolioState extends State<SetFolio> {
  final TextEditingController folio = TextEditingController();
  final pattern = RegExp(r'\D');
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          style: GoogleFonts.quicksand(color: TX1, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
              errorStyle: GoogleFonts.quicksand(
                  color: TX2, fontWeight: FontWeight.w500),
              hintStyle: GoogleFonts.quicksand(
                  color: TX2, fontWeight: FontWeight.w500),
              hintText: 'Folio'),
          autovalidateMode: AutovalidateMode.always,
          controller: widget.initial,
          validator: (value) {
            if (value.isEmpty) {
              return 'Ingrese un folio';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // pattern.hasMatch checks for non digits in this field
            // the field
            if (!pattern.hasMatch(value) && value.isNotEmpty) {
              String _temp = value;
              context.cubit<OrderCubit>().state.setFolium(int.parse(_temp));
            }
          },
        ),
      ),
    );
  }
}

class AddRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: PR2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        icon: Icon(
          MdiIcons.washingMachine,
          color: TX1,
        ),
        onPressed: () {
          HapticFeedback.mediumImpact();
          context.cubit<OrderCubit>().increment();
          print('\n *****');
          print(context.cubit<OrderCubit>().state.items.toString());
        },
      ),
    );
  }
}
