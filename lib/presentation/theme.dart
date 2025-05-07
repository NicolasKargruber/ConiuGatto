import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

// Define your seed colors.
const Color primarySeedColor = Color(0xFF1565C0);
const Color secondarySeedColor = Color(0xFF68D3FF);
const Color tertiarySeedColor = Color(0xFF6CA450);

// Make a LIGHT ColorScheme from the seeds.
final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  secondary: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: myLightTones,
);

// Custom LIGHT Tones
const FlexTones myLightTones = FlexTones.light(
  primaryTone: 35,
  tertiaryContainerTone: 85,
  neutralChroma: 12,
  neutralVariantChroma: 100,
  paletteType: FlexPaletteType.extended,
);

// Make a DARK ColorScheme from the seeds.
final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: myDarkTones,
);

// Custom DARK Tones
const FlexTones myDarkTones = FlexTones.dark(
  secondaryContainerTone: 80,
  onSecondaryContainerTone: 20,
  neutralChroma: 15,
  neutralVariantChroma: 40,
  paletteType: FlexPaletteType.extended,
);