import 'package:flutter/material.dart';

import '../data/enums/auxiliary.dart';
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

class RegularityWidgetFactory {
  static Widget createButton({required bool isRegular}) {
    return ButtonFactory.createFilledButton(
      tonal: !isRegular,
      label: isRegular ? "Regular" : "Irregular",
    );
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

class AuxiliaryWidgetFactory {
  static Widget createChip({required String label}) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.green.shade300)),
      side: BorderSide(color: Colors.green.shade300),
    );
  }

  static Widget createToggleButtons({
    required Auxiliary selected,
    required Function(Auxiliary?) onToggle,
  }) {
    final auxiliaries = Auxiliary.values;
    final List<bool> selectedAuxiliaries = auxiliaries.map((e) => e == selected).toList();
    return ToggleButtons(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.green.shade700,
      selectedColor: Colors.white,
      fillColor: Colors.green.shade200,
      color: Colors.green.shade400,
      constraints: const BoxConstraints(minHeight: AppValues.s40, minWidth: AppValues.s80),
      onPressed: (index) => onToggle(auxiliaries.elementAtOrNull(index)),
      isSelected: selectedAuxiliaries,
      children: auxiliaries.map((e) => Text(e.label)).toList(),
    );
  }
}

class ItalianTenseProgressFactory {
  static Widget createCard({
    required String languageLevelLabel,
    required String title,
    required String subtitle,
    required double progress,
    double milestone = 0.75,
    Function()? onTap,
  }){
    return Builder(
        builder: (context) {
          final isReached = progress > milestone;
          return Card(
            color: isReached ? Color.alphaBlend(Colors.green.withAlpha(50), context.colorScheme.surface) : null,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppValues.r12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppValues.p4, AppValues.p4, AppValues.p4, AppValues.p0),
                child: ListTile(
                  isThreeLine: true,
                  title: Text(title),
                  leading: CircleAvatar(
                    backgroundColor: isReached ? context.colorScheme.tertiaryContainer : null,
                    child: Text(languageLevelLabel,
                        style: isReached ? TextStyle(color: context.colorScheme.onTertiaryContainer) : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subtitle,
                        style: isReached ? TextStyle(color: context.colorScheme.onTertiaryContainer) : null,
                      ),
                      SizedBox(height: AppValues.s12),
                      ItalianTenseProgressFactory.createLinearProgressIndicator(value: progress, milestone: milestone),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  static Widget createLinearProgressIndicator({required double value, required double milestone, bool showIndicator = true}) {
    final isReached = value > milestone;
    final firstProgressValue = isReached ? 1.0 : value / milestone;
    final secondProgressValue = isReached ? (value - milestone) / (1.0 - milestone) : 0.0;
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex:  (milestone * 100).toInt(),
                  child: LinearProgressIndicator(
                    color: isReached ? context.colorScheme.tertiary : null,
                    backgroundColor: isReached ? context.colorScheme.tertiaryContainer : null,
                    value: firstProgressValue,
                  ),
                ),
                SizedBox(width: AppValues.s4),
                Flexible(
                  flex: ((1.0 - milestone) * 100).toInt(),
                  child: LinearProgressIndicator(
                    color: isReached ? context.colorScheme.tertiary : null,
                    backgroundColor: isReached ? context.colorScheme.tertiaryContainer : null,
                    value: secondProgressValue,
                  ),
                ),
              ],
            ),
            if(showIndicator) Align(
              alignment: Alignment((milestone - 0.5) * 2.15, 0),
              child: Icon(Icons.arrow_drop_up_rounded,
                color: isReached ? context.colorScheme.tertiary : null,
              ),
            ),
          ],
        );
      }
    );
  }
}

class LanguageLevelProgressFactory {
  static Widget createLabeledCircularProgressIndicator({required String label, required double progress}) =>
      Builder(builder: (context) {
        final isFull = progress == 1.0;
        return Container(
          padding: const EdgeInsets.all(AppValues.p12),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CircleAvatar(
                backgroundColor: isFull ? context.colorScheme.primary : null,
                child: Text(label, style: TextStyle(
                  color: isFull ? context.colorScheme.onPrimary : null,
                  fontWeight: FontWeight.w600,
                  fontSize: AppValues.fs16,
                )),
              ),

              SizedBox(
                width: AppValues.s52,
                height: AppValues.s52,
                child: CircularProgressIndicator(
                  backgroundColor: context.colorScheme.primaryContainer,
                  value: progress,
                  color: context.colorScheme.primary,
                  strokeCap: StrokeCap.round,
                  strokeWidth: AppValues.s6,
                ),
              ),
            ],
          ),
        );
      }
      );
}