import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/outcomesview/outcome_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/widgets/customtext.dart';
import 'package:vadmin/widgets/repository.dart';

class OutcomeRowItem extends StatefulWidget {
  final int index;
  const OutcomeRowItem({Key key, this.index}) : super(key: key);

  @override
  _OutcomeRowItemState createState() => _OutcomeRowItemState();
}

class _OutcomeRowItemState extends State<OutcomeRowItem> {
  @override
  Widget build(BuildContext context) {
    Outcome lstate = context.cubit<OutcomeCubit>().state;
    return Column(
      children: [
        MyDropMenu(
          foutcome: lstate.items,
          ddmitems: OUTCOMESMENU,
          id: widget.index,
          superF: setState,
        ),
        MyItemCounter(
          foutcome: lstate.items,
          id: this.widget.index,
          superF: setState,
        ),
      ],
    );
  }
}

class MyDropMenu extends StatefulWidget {
  final List<List> foutcome;
  final List<DropdownMenuItem> ddmitems;
  final int id;
  final Function superF;
  MyDropMenu(
      {Key key,
      @required this.foutcome,
      @required this.ddmitems,
      @required this.id,
      @required this.superF});

  @override
  _MyDropMenuState createState() => _MyDropMenuState();
}

class _MyDropMenuState extends State<MyDropMenu> {
  @override
  Widget build(BuildContext context) {
    String _value;
    _value = widget.foutcome[widget.id][0];
    return DropdownButton(
      underline: Container(
        color: Colors.white,
        height: 1,
      ),
      iconEnabledColor: CN2,
      dropdownColor: CN2,
      onTap: () => HapticFeedback.mediumImpact(),
      icon: const Icon(Icons.arrow_downward),
      iconSize: 25,
      value: _value,
      items: widget.ddmitems,
      onChanged: (value) {
        HapticFeedback.mediumImpact();
        // TODO Move this to the cubitLogic
        _value = value;
        context.cubit<OutcomeCubit>().state.items[widget.id][0] = value;
        context.cubit<OutcomeCubit>().refreshBill;
        setState(() {});
        widget.superF(() {});
      },
    );
  }
}

class MyItemCounter extends StatelessWidget {
  final List<List> foutcome;
  final int id;
  final Function superF;
  MyItemCounter(
      {Key key,
      @required this.foutcome,
      @required this.id,
      @required this.superF})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: CN1,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.remove, color: Colors.white),
            ),
            onTap: () {
              if (context.cubit<OutcomeCubit>().state.countAt(this.id) > 10) {
                HapticFeedback.mediumImpact();
                context.cubit<OutcomeCubit>().minusAt(this.id, 10);
                this.superF(() {});
              }
            },
            onLongPress: () {
              if (context.cubit<OutcomeCubit>().state.countAt(this.id) > 100) {
                HapticFeedback.mediumImpact();
                context.cubit<OutcomeCubit>().minusAt(this.id, 100);
                this.superF(() {});
              }
            },
          ),
          Expanded(
            flex: 3,
            child: IconButton(
              icon: Icon(Icons.radio_button_checked, size: 10, color: TX1),
              onPressed: () {
                if (context.cubit<OutcomeCubit>().state.countAt(this.id) > 1) {
                  HapticFeedback.mediumImpact();
                  context.cubit<OutcomeCubit>().state.minusAt(this.id, 1);
                  this.superF(() {});
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: IconButton(
              icon: Icon(Icons.radio_button_checked, size: 10, color: TX1),
              onPressed: () {
                HapticFeedback.mediumImpact();
                context.cubit<OutcomeCubit>().plusAt(this.id, 1);
                this.superF(() {});
              },
            ),
          ),
          GestureDetector(
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: CN1,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            onTap: () {
              HapticFeedback.mediumImpact();
              context.cubit<OutcomeCubit>().plusAt(this.id, 10);
              this.superF(() {});
            },
            onLongPress: () {
              HapticFeedback.mediumImpact();
              context.cubit<OutcomeCubit>().plusAt(this.id, 100);
              this.superF(() {});
            },
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: CustomText(
                key: Key(context.cubit<OutcomeCubit>().state.items.toString()),
                text: context.cubit<OutcomeCubit>().state.countPriceAt(this.id),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
