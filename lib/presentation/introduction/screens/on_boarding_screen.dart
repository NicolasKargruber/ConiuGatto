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
        PageViewModel(
          title: "Language Levels",
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  "Italian tense are grouped into the following CEFR levels: A1, A2, B1, B2 and C1.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.r12),
                  child: Image.asset('assets/introduction_language_level.jpg'),
                ),
                Text(
                  "After reaching fluency in the tense it will be successfully marked as fluent.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: "Quizzing verbs",
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  "Every quiz question consists of a VERB, TENSE (+ MOOD) and PRONOUN.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.r12),
                  child: Image.asset('assets/introduction_quiz.jpg'),
                ),
                Text(
                  "In order to answer a question you must conjugate the verb accordingly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: "Double Auxiliary",
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  "Some italian verbs can use both \nAVERE and ESSERE.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.r12),
                  child: Image.asset('assets/introduction_double_auxiliary.jpg'),
                ),
                Text(
                  "You can choose which auxiliary the conjugation tables will display.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs18),
                ),
              ],
            ),
          ),
          decoration: PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: "Report an issue",
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p28),
            child: Column(
              spacing: AppValues.s24,
              children: [
                Text(
                  "All conjugations have a little flag somewhere. By tapping this flag, you can report an issue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
                Row(
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
                Text(
                  "This helps me (the developer) out a lot!",
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
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
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