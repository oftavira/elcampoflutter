import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/models/sale_model.dart';
import 'package:vadmin/ordernoteview/order_cubit.dart';
import 'package:vadmin/ordernoteview/foot_note.dart';
import 'package:vadmin/ordernoteview/header_note.dart';
import 'package:vadmin/ordernoteview/row_note.dart';
import 'package:vadmin/widgets/notedecorator.dart';

// The order can be called with an existing order or create it if wished
// if an existing sales is required we can pass it with the settings.name
// option

class OrderNote extends StatelessWidget {
  final Sale sale;
  const OrderNote({
    Key key,
    this.sale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    // Cubit Provider feeds the context with an ancestor cubit
    return CubitProvider(
      create: (_) => OrderCubit(this.sale),
      child: CubitBuilder<OrderCubit, Sale>(
        builder: (context, state) {
          // This GestureDetector wraps the entire view to enable unfocus behaviour
          // triggered if other field that is non editable is tapped
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: NoteDecorator(
              r: 25,
              chld: Column(
                children: [
                  HeaderNote(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration:
                                BoxDecoration(border: Border.all(color: PR2)),
                            child: Dismissible(
                              key: Key(state.items[index].hashCode.toString()),
                              child: NoteRowItem(
                                index: index,
                              ),
                              onDismissed: (direction) {
                                context.cubit<OrderCubit>().delAt(index);
                              },
                            ),
                          );
                        },
                        itemCount: state.items.length),
                  ),
                  Billing(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
