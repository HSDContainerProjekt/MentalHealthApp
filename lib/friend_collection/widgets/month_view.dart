import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MonthView extends StatefulWidget {
  final String currentMonth;
  final List<List<String>> friends;
  const MonthView(this.currentMonth, this.friends, {super.key});

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.currentMonth)
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.date),
                Text(AppLocalizations.of(context)!.name),          
              ],
            ),          
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.friends.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.friends.elementAt(index).elementAt(0)),
                    Text(widget.friends.elementAt(index).elementAt(1)),                    
                  ],
                )
              );
            },
          ),
        ],
      ),
    );
  }
}