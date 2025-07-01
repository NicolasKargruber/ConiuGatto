import 'package:flutter/material.dart';

import '../../utilities/extensions/build_context_extensions.dart';

enum Regularity {
  regular('regular'),
  irregular('irregular'),
  highlyIrregular('highly irregular');

  final String jsonKey;
  const Regularity(this.jsonKey);

  bool get isRegular => this == Regularity.regular;

  factory Regularity.fromJson(dynamic json)
  => Regularity.values.firstWhere((e) => e.jsonKey == json);
}

extension on Regularity {
   String getLabel(BuildContext context) => switch(this){
     Regularity.regular => context.localization.regular,
     Regularity.irregular => context.localization.irregular,
     Regularity.highlyIrregular => context.localization.highlyIrregular,
   };
}