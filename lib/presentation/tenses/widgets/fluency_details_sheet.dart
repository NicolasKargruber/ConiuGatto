import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class FluencyDetailsSheet extends StatelessWidget {
  const FluencyDetailsSheet({
    super.key,
    required this.label,
    required this.fluency,
    required this.daysAgoLabel,
    required this.example,
    required this.exampleTranslation,
    this.milestonePassed = false,
  });

  final String label;
  final double fluency;
  final String daysAgoLabel;
  final String example;
  final String exampleTranslation;
  final bool milestonePassed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.p48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !milestonePassed ? context.colorScheme.primary : context.colorScheme.tertiary,
              borderRadius: BorderRadius.all(Radius.circular(AppValues.r4)),
            ),
            padding: EdgeInsets.symmetric(vertical: AppValues.p12, horizontal: AppValues.p60),
            child: AutoSizeText(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppValues.fs24,
                color: !milestonePassed ? context.colorScheme.onPrimary : context.colorScheme.onTertiary,
              ),
              maxLines: 1,
            ),
          ),

          SizedBox(height: AppValues.s20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p24),
            child: AutoSizeText(
              context.localization.tenseExample("$example - $exampleTranslation"),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: AppValues.fs18, fontStyle: FontStyle.italic),
              maxLines: 1,
            ),
          ),

          SizedBox(height: AppValues.s28),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(context.localization.fluencyScoreLabel,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16),
                  ),

                  SizedBox(height: AppValues.s12),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            !milestonePassed
                                ? context.colorScheme.primaryContainer
                                : context.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(AppValues.r12)),
                      ),
                      padding: EdgeInsets.all(AppValues.p12),
                      child: Text(
                        "${(fluency * 100).round()}%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.fs24,
                          color:
                              !milestonePassed
                                  ? context.colorScheme.onPrimaryContainer
                                  : context.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(context.localization.lastQuizzedLabel,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16),
                  ),

                  SizedBox(height: AppValues.s12),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            !milestonePassed
                                ? context.colorScheme.primaryContainer
                                : context.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(AppValues.r12)),
                      ),
                      padding: EdgeInsets.all(AppValues.p12),
                      child: Text(
                        daysAgoLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.fs20,
                          color:
                              !milestonePassed
                                  ? context.colorScheme.onPrimaryContainer
                                  : context.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if(milestonePassed)
            ...[
              SizedBox(height: AppValues.s36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppValues.p52),
                child: Text(context.localization.fluencyReachedLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16),
                ),
              ),
            ]
        ],
      ),
    );
  }
}
