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
      child: Scaffold(
        body: GestureDetector(
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
                  DataColumn(
                      label: Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                    image: AssetImage(
                        "lib/assets/images/bookmarks/table_of_contents.png"),
                  ))))),
                  DataColumn(
                      label: Expanded(
                          child: Text(AppLocalizations.of(context)!.chapter))),
                  DataColumn(label: Expanded(child: Text(""))),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        image: AssetImage(
                            "lib/assets/images/bookmarks/main_page.png"),
                      )))),
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
                      DataCell(Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        image: AssetImage(
                            "lib/assets/images/bookmarks/routine.png"),
                      )))),
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
                      DataCell(Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        image: AssetImage(
                            "lib/assets/images/bookmarks/friends.png"),
                      )))),
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
                      DataCell(Text("4")),
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
