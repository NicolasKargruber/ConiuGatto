import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings ⚙️")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text("Tenses", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
          ),
           SizedBox(height: 8),
           ListTile(title: Text("The following tenses will be included in your Quiz."),),
           ListTile(title: Center(child: FilledButton.tonal(onPressed: (){},child:Text("Update tenses"))),),

          SizedBox(height: 8),

          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text("Verbs", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
          ),
          SizedBox(height: 8),
          ListTile(title: Text("The following verbs will be included up in your Quiz."),),
          ListTile(title: Center(child: FilledButton.tonal(onPressed: null, child:Text("Update verbs"))),),

          SizedBox(height: 8),

          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text("Pronouns", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
          ),
          SizedBox(height: 8),
          ListTile(title: Text("The following pronouns will be included up in your Quiz."),),
          ListTile(title: Center(child: FilledButton.tonal(onPressed: null, child:Text("Update pronouns"))),),

        ],
      ),
    );
  }
}
