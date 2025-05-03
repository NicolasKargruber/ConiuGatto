import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({super.key, required this.columns, required this.rows, required this.decoration});

  final List<DataColumn> columns;
  final List<DataRow> rows;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        headingRowColor: WidgetStateColor.resolveWith((states) => context.colorScheme.inverseSurface),
        dividerThickness: AppValues.s1,
        dataRowMinHeight: AppValues.s48,
        dataRowMaxHeight: AppValues.s52,
        headingRowHeight: AppValues.s56,
        clipBehavior: Clip.hardEdge,
        columns: columns, rows: rows,
        decoration: decoration,
    );
  }
}
