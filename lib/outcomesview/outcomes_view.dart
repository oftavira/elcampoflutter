import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/models/outcome_model.dart';
import 'package:vadmin/outcomesview/foot_outcome.dart';
import 'package:vadmin/outcomesview/header_outcome.dart';
import 'package:vadmin/outcomesview/outcome_cubit.dart';
import 'package:vadmin/outcomesview/row_outcome.dart';
import 'package:vadmin/widgets/notedecorator.dart';

// The order can be called with an existing order or create it if wished
// if an existing outcomes is required we can pass it with the settings.name
// option

class OutcomesView extends StatelessWidget {
  final Outcome outcome;
  const OutcomesView({
    Key key,
    this.outcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    // Cubit Provider feeds the context with an ancestor cubit
    return CubitProvider(
      create: (_) => OutcomeCubit(this.outcome),
      child: CubitBuilder<OutcomeCubit, Outcome>(
        builder: (context, state) {
          // This GestureDetector wraps the entire view to enable unfocus behaviour
          // triggered if other field that is non editable is tapped
          return NoteDecorator(
            r: 25,
            chld: Column(
              children: [
                HeaderOutcome(),
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
                            child: OutcomeRowItem(
                              index: index,
                            ),
                            onDismissed: (direction) {
                              context.cubit<OutcomeCubit>().delAt(index);
                            },
                          ),
                        );
                      },
                      itemCount: state.items.length),
                ),
                SendOutcome(),
              ],
            ),
          );
        },
      ),
    );
  }
}
