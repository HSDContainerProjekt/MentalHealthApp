import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../software_backbone/themes/theme_constraints.dart';

class TableOfContent extends StatelessWidget {
  const TableOfContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ableOfContentsPageThemeData,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeatY,
            fit: BoxFit.cover,
            image: AssetImage(
                "lib/assets/images/background_paper/paper_shadow/dotted_paper_white-purple_shadow.jpg"),
          ),
        ),
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                showBottomBorder: false,
                columns: [
                  DataColumn(label: Text("")),
                  DataColumn(
                      label: Expanded(
                          child: Text(AppLocalizations.of(context)!.chapter))),
                  DataColumn(label: Expanded(child: Text(""))),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Icon(Icons.circle, color: mainPageColorScheme.primary)),
                      DataCell(
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, mainPage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.homepageTitle,
                          ),
                        ),
                      ),
                      DataCell(Text("1")),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Icon(Icons.circle, color: routinePageColorScheme.primary)),
                      DataCell(
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, routineTracking);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.routineTitle,
                          ),
                        ),
                      ),
                      DataCell(Text("2")),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Icon(Icons.circle, color: friendsPageColorScheme.primary)),
                      DataCell(
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, friendsCollection);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.friendCollectionTitle,
                          ),
                        ),
                      ),
                      DataCell(Text("3")),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Icon(Icons.circle, color: resourcesPageColorScheme.primary)),
                      DataCell(
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, resources);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.resourcesTitle,
                          ),
                        ),
                      ),
                      DataCell(Text("4")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
