import 'package:flutter/material.dart';

class SizingInformation {
  final Orientation orientation;
  final Size screenSize;
  final Size widgetSize;

  SizingInformation({this.orientation, this.screenSize, this.widgetSize});

  @override
  String toString() {
    return 'orientation: $orientation screenSize: $screenSize widgetSize: $widgetSize';
  }
}

class SizedWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) theBuilder;
  const SizedWidget({Key key, this.theBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQuery = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          orientation: mediaQuery.orientation,
          screenSize: mediaQuery.size,
          widgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );

        return theBuilder(context, sizingInformation);
      },
    );
  }
}