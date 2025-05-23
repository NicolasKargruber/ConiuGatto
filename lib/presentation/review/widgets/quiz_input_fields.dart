import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/review_view_model.dart';

// TODO Move to general widgets
class QuizInputFields extends StatelessWidget {
  const QuizInputFields({super.key, required this.textController, required this.onSubmitted});
  
  final TextEditingController textController;
  final void Function(String) onSubmitted;

  static final _logTag = (QuizInputFields).toString();

  void _addLetterAtSelection(String letter) {
    final selection = textController.selection;
    final text = textController.text;

    // Handle text replacement when there's a selection
    if (selection.isValid && !selection.isCollapsed) {
      final start = selection.start;
      final end = selection.end;
      textController.text = text.replaceRange(start, end, letter);
      textController.selection = TextSelection.collapsed(offset: start + letter.length);
    }
    // Handle normal insertion at cursor position
    else {
      final cursorPosition = selection.base.offset;
      textController.text = text.replaceRange(cursorPosition, cursorPosition, letter);
      textController.selection = TextSelection.collapsed(offset: cursorPosition + letter.length);
    }

    debugPrint("$_logTag | ${selection.isCollapsed ? 'Added' : 'Replaced'} '$letter' in answer");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<ReviewViewModel>();
    
    return Column(
      children: [
        // Answer Text Field
        TextField(
          textAlign: TextAlign.center,
          controller: textController,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            suffixIconConstraints: BoxConstraints(
              maxHeight: AppValues.s24,
              maxWidth: AppValues.s24,
            ),
            suffixIcon: IconButton.filled(
              padding: EdgeInsets.all(AppValues.p0),
              onPressed: textController.clear,
              icon: Icon(Icons.clear, size: AppValues.s12, color: context.colorScheme.onPrimary),
            ),
          ),
        ),

        // Wrong Answer Message
        if(viewModel.currentAnswerResult case var result?)
          Text(result.message),

        SizedBox(height: AppValues.s4),

        // Accents Buttons
        Wrap(children: ["è", "à", "ò", "é"]
            .map((letter) => ActionChip(
          label: Text(letter),
          onPressed: () => _addLetterAtSelection(letter),
        )).toList()),
      ],
    );
  }
}
