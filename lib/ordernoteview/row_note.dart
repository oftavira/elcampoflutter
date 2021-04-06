import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/models/sale_model.dart';
import 'package:vadmin/ordernoteview/order_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/widgets/customtext.dart';
import 'package:vadmin/widgets/repository.dart';

class NoteRowItem extends StatefulWidget {
  final int index;
  const NoteRowItem({Key key, this.index}) : super(key: key);

  @override
  _NoteRowItemState createState() => _NoteRowItemState();
}

class _NoteRowItemState extends State<NoteRowItem> {
  @override
  Widget build(BuildContext context) {
    Sale lstate = context.cubit<OrderCubit>().state;
    return Column(
      children: [
        MyDropMenu(
          forder: lstate.items,
          ddmitems: MENU,
          id: widget.index,
          superF: setState,
        ),
        MyItemCounter(
          forder: lstate.items,
          id: this.widget.index,
          superF: setState,
        ),
      ],
    );
  }
}

class MyDropMenu extends StatefulWidget {
  final List<List> forder;
  final List<DropdownMenuItem> ddmitems;
  final int id;
  final Function superF;
  MyDropMenu(
      {Key key,
      @required this.forder,
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
    _value = widget.forder[widget.id][0];
    return Row(children: [
      DropdownButton(
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
          context.cubit<OrderCubit>().state.items[widget.id][0] = value;
          context.cubit<OrderCubit>().refreshBill;
          setState(() {});
          widget.superF(() {});
        },
      ),
      Expanded(
        child: Center(
          child: Text(
            'Cantidad: ' +
                context.cubit<OrderCubit>().state.countMoney(widget.id),
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 16, color: TX1),
          ),
        ),
      ),
    ]);
  }
}

class MyItemCounter extends StatelessWidget {
  final List<List> forder;
  final int id;
  final Function superF;
  MyItemCounter(
      {Key key,
      @required this.forder,
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
              if (context.cubit<OrderCubit>().state.countAt(this.id) > 10) {
                HapticFeedback.mediumImpact();
                context.cubit<OrderCubit>().minusAt(this.id, 10);
                this.superF(() {});
              }
            },
            onLongPress: () {
              if (context.cubit<OrderCubit>().state.countAt(this.id) > 100) {
                HapticFeedback.mediumImpact();
                context.cubit<OrderCubit>().minusAt(this.id, 100);
                this.superF(() {});
              }
            },
          ),
          Expanded(
            flex: 3,
            child: IconButton(
              icon: Icon(Icons.radio_button_checked, size: 10, color: TX1),
              onPressed: () {
                if (context.cubit<OrderCubit>().state.countAt(this.id) > 1) {
                  HapticFeedback.mediumImpact();
                  context.cubit<OrderCubit>().state.minusAt(this.id, 1);
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
                context.cubit<OrderCubit>().plusAt(this.id, 1);
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
              context.cubit<OrderCubit>().plusAt(this.id, 10);
              this.superF(() {});
            },
            onLongPress: () {
              HapticFeedback.mediumImpact();
              context.cubit<OrderCubit>().plusAt(this.id, 100);
              this.superF(() {});
            },
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: CustomText(
                key: Key(context.cubit<OrderCubit>().state.items.toString()),
                text: context.cubit<OrderCubit>().state.countPriceAt(this.id),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
