import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MonthView extends StatefulWidget {
  final String currentMonth;
  const MonthView(this.currentMonth, {super.key});

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: Column(
        children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.currentMonth)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.january),
            Text(AppLocalizations.of(context)!.february)
          ],
        )
        ],
      ),
    );
  }
}