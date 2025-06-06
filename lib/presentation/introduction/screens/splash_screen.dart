import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home_screen.dart';
import '../view_models/splash_view_model.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SplashViewModel>();
    return viewModel.isSkipIntroduction ? HomeScreen() : OnBoardingScreen(
      onIntroEnd: viewModel.skipIntroduction,
    );
  }
}