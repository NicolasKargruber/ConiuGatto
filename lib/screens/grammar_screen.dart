import 'package:flutter/material.dart';

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grammar 🏆")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level A1",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Presente, Imperfetto, Passato Prossimo, Futuro",
                    style: TextStyle(fontSize: 16),),
                ],
              ),
            ),

            SizedBox(height: 24.0),

            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level A2",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Trapassato Prossimo, Condizionale Presente, Imperativo",
                    style: TextStyle(fontSize: 16),),
                ],
              ),
            ),

            SizedBox(height: 24.0),



            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level B1",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(overflow: TextOverflow.ellipsis , "Yet more to come ... 🙃🙃🙃",
                    style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
