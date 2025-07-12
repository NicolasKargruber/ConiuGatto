import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key, required this.onIntroEnd});

  final Function() onIntroEnd;

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      allowImplicitScrolling: true,
      pages: [
        // Language Levels
        PageViewModel(
          title: context.localization.languageLevelsTitle,
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  context.localization.languageLevelsSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppValues.s480),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.r12),
                    child: Image.asset('assets/introduction_language_level.jpg'),
                  ),
                ),
                Text(
                  context.localization.languageLevelsBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        // Quizzing verbs
        PageViewModel(
          title: context.localization.quizzingVerbsTitle,
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  context.localization.quizzingVerbsSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppValues.s480),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.r12),
                    child: Image.asset('assets/introduction_quiz.jpg'),
                  ),
                ),
                Text(
                  context.localization.quizzingVerbsBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        // Starring verbs
        PageViewModel(
          title: context.localization.starringVerbsTitle,
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  context.localization.starringVerbsSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppValues.s480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppValues.s12,
                    children: [
                      Flexible(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.r12),
                          child: Image.asset('assets/introduction_starred_verbs.jpeg'),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: AppValues.s12,
                          children: [
                            Flexible(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppValues.r12),
                                child: Image.asset('assets/introduction_star_button.jpeg'),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppValues.r12),
                                child: Image.asset('assets/introduction_slide_to_star.jpeg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.localization.starringVerbsBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        // Double Auxiliary
        PageViewModel(
          title: context.localization.doubleAuxiliaryTitle,
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  context.localization.doubleAuxiliarySubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppValues.s480),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.r12),
                    child: Image.asset('assets/introduction_double_auxiliary.jpg'),
                  ),
                ),
                Text(
                  context.localization.doubleAuxiliaryBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        // Report Issue
        PageViewModel(
          title: context.localization.reportIssueTitle,
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  context.localization.reportIssueSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppValues.s480),
                  child: Row(
                    spacing: AppValues.s16,
                    children: [
                      Flexible(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.r12),
                          child: Image.asset('assets/introduction_flag_conjugation.jpg'),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.r12),
                          child: Image.asset('assets/introduction_flag_solution.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.localization.reportIssueBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          //decoration: pageDecoration,
        ),
      ],
      onDone: widget.onIntroEnd,
      onSkip: widget.onIntroEnd,
      // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: Text(context.localization.skip, style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: Text(context.localization.done, style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(AppValues.p16),
      dotsDecorator: DotsDecorator(
        size: const Size(AppValues.s12, AppValues.s12),
        color: context.colorScheme.surfaceContainerHighest,
        activeColor: context.colorScheme.primary,
        activeSize: const Size(AppValues.s24, AppValues.s12),
        activeShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppValues.r24))),
      ),
    );
  }
}
