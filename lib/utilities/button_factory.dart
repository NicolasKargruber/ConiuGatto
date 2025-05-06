import 'package:flutter/material.dart';

import 'app_values.dart';
import 'extensions/build_context_extensions.dart';

class ButtonFactory {
  static Widget createFilledButton({required bool tonal, required String label}) {
    if(tonal) {
      return FilledButton.tonal(onPressed: (){}, child: Text(label));
    } else {
      return FilledButton(onPressed: (){}, child: Text(label));
    }
  }

  static Widget createSelectableIconButton({
    required bool selected,
    required Function() onPressed,
  }) => Builder(builder: (context) {
    if(selected) {
      return IconButton(
        style: IconButton.styleFrom(
          backgroundColor: context.isLightMode ? Colors.yellow.shade700 : Colors.yellow.shade600,
        ),
        onPressed: onPressed,
        icon: Icon(Icons.star),
        color: context.isLightMode ? Colors.yellow.shade50 : Colors.yellow.shade900,
        //color: Colors.yellow.shade300,
      );
    }
    return IconButton.outlined(
      style: IconButton.styleFrom(
        side: BorderSide(
            width: AppValues.s2,
            color: context.isLightMode ? Colors.yellow.shade500 : Colors.yellow.shade200
        ),
      ),
      onPressed: onPressed,
      icon: Icon(Icons.star_border_rounded),
      color: context.isLightMode ? Colors.yellow.shade800 : Colors.yellow.shade700,
    );
  });
}