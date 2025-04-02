import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz 🕹️")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Presente",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
              ),

              Text(
                "(I eat)",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),

              SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  //color: Colors.blue.shade100,
                  border: Border.all(color: Colors.blue.shade100, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  "io mangio",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                ),
              ),
              
              SizedBox(height: 48),
              
              FilledButton(onPressed: (){}, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Check",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
