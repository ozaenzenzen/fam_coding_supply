import 'package:flutter/widgets.dart';

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: this,
      );
}
