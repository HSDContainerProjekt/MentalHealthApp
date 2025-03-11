import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TableOfContent extends StatelessWidget {
  const TableOfContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              Navigator.pop(context);
            }
          },
        child: Padding(
          padding: EdgeInsets.all(6),
          child: 
          SizedBox(width: double.infinity,
              child: DataTable(
              showBottomBorder: false,
              
              columns: [
                DataColumn(label: Expanded(child: Text(""))),
                DataColumn(label: Expanded(child: Text("Kapitel")))
              ], 
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text("1")),
                    DataCell( 
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, mainPage);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.homepageTitle,
                        )
                      )
                    ),
                  ]
                ),
                DataRow(
                  cells: [
                    DataCell(Text("2")),
                    DataCell( 
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, routineTracking);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.routineTitle,
                        )
                      )
                    )
                  ]
                ),
                DataRow(
                  cells: [
                    DataCell(Text("3")),
                    DataCell( 
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, friendsCollection);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.friendCollectionTitle,
                        )
                      )
                    )
                  ]
                ),
                DataRow(
                  cells: [
                    DataCell(Text("4")),
                    DataCell( 
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, resources);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.resourcesTitle, 
                        )
                      )
                    )
                  ]
                )
              ] 
            ))
          
          )
      )
    );
  }
}

/**
 * ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context)!.tableOfContentTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              )),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, mainPage);
              },
              child: Text(
                AppLocalizations.of(context)!.homepageTitle,
                style: Theme.of(context).textTheme.displayLarge
                )
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, routineTracking);
              },
              child: Text(
                AppLocalizations.of(context)!.routineTitle,
                style: Theme.of(context).textTheme.displayLarge
              )
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, friendsCollection);
              },
              child: Text(
                AppLocalizations.of(context)!.friendCollectionTitle,
                style: Theme.of(context).textTheme.displayLarge
              )
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, resources);
              },
              child: Text(
                AppLocalizations.of(context)!.resourcesTitle, 
                style: Theme.of(context).textTheme.displayLarge
              )
            )
          ],
        ),
 */
