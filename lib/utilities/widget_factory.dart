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
}

class StarWidgetFactory {
  static Widget createDismissable({
    required  ValueKey<String> key,
    required bool isStarred,
    required Function onDismissed,
    required  Widget child,
  }) {
    return Dismissible(
      key: key,
      background: Container(
        color: Colors.yellow.shade500,
        child: Icon(isStarred ? Icons.star_border_rounded : Icons.star_rounded, color: Colors.yellow.shade900),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDismissed();
        return false;
      },
      child: child,
    );
  }

  static Widget createIcon({bool isStarred = true}) =>
      Builder(builder: (context) {
        if (isStarred) {
          return Icon(Icons.star,
            color: context.isLightMode ? Colors.yellow.shade800 : Colors.yellow.shade500,
          );
        }
        return Icon(Icons.star_border_rounded,
          color: context.isLightMode ? Colors.yellow.shade500 : Colors.yellow.shade200,
        );
      });

  static Widget createSelectableIconButton({
    required bool isStarred,
    required Function() onPressed,
  }) => Builder(builder: (context) {
    if(isStarred) {
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