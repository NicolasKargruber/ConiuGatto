import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';

class BuyMeACoffeeButton extends StatelessWidget {
  const BuyMeACoffeeButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final imagePath = context.isDarkMode ? "assets/buy_me_a_coffee_dark.jpg" : "assets/buy_me_a_coffee_light.png";

    return Transform.scale(
      scale: 0.7,
      child: Material(
        borderRadius: BorderRadius.circular(AppValues.r48),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Ink.image(
            image: AssetImage(imagePath),
            height: AppValues.s88,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
