import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../utilities/extensions/build_context_extensions.dart';

final _logTag = (GrammarScreen).toString();

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grammar 🏆")),
      body: Padding(
        padding: const EdgeInsets.all(AppValues.p16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(AppValues.p16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.colorScheme.primaryContainer.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(AppValues.p12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level A1",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppValues.fs24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Presente, Imperfetto, Passato Prossimo, Futuro",
                    style: TextStyle(fontSize: AppValues.fs16),),
                ],
              ),
            ),

            SizedBox(height: AppValues.s24),

            Container(
              padding: const EdgeInsets.all(AppValues.p16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.colorScheme.primaryContainer.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppValues.r12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level A2",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppValues.fs24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Trapassato Prossimo, Condizionale Presente, Imperativo",
                    style: TextStyle(fontSize: AppValues.fs16),),
                ],
              ),
            ),

            SizedBox(height: AppValues.s24),

            Container(
              padding: const EdgeInsets.all(AppValues.p16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppValues.r12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level B1",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppValues.fs24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Yet more to come ... 🙃🙃🙃",
                    style: TextStyle(fontSize: AppValues.fs16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
