import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/review_view_model.dart';

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
          enableSuggestions: false,
          autocorrect: false,
          onEditingComplete: () {}, // this prevents keyboard from closing
          textAlign: TextAlign.center,
          controller: textController,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: viewModel.hasCorrectAnswer ? context.colorScheme.tertiary : context.colorScheme.primary,
                width: AppValues.s2,
              ),
            ),
            enabledBorder: viewModel.hasCorrectAnswer ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.tertiary,
                width: AppValues.s2,
              ),
            ) : null,
            suffixIconConstraints: BoxConstraints(
              maxHeight: AppValues.s24,
              maxWidth: AppValues.s24,
            ),
            suffixIcon: IconButton.filled(
              padding: EdgeInsets.all(AppValues.p0),
              onPressed: textController.clear,
              style: viewModel.hasCorrectAnswer
                  ? IconButton.styleFrom(backgroundColor: context.colorScheme.tertiary)
                  : null,
              icon: Icon(
                Icons.clear,
                size: AppValues.s12,
                color: viewModel.hasCorrectAnswer ? context.colorScheme.onTertiary : context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),

        // Wrong Answer Message
        if(viewModel.currentAnswerResult case var result?)
          ...[
            SizedBox(height: AppValues.s4),
            Text(result.message),
          ],

        SizedBox(height: AppValues.s4),

        // Accents Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.p12),
          child: FittedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["è", "à", "ò", "ì", "é"].map((letter) {
                  return ActionChip(
                    label: Text(letter),
                    onPressed: () => _addLetterAtSelection(letter),
                  );
                }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
