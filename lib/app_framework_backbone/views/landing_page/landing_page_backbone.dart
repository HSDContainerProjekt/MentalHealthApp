import 'package:flutter/material.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/landing_page/widgets/animal_selection.dart';
import 'package:mental_health_app/friend_collection/database/account_init_db.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:model_viewer_plus/model_viewer_plus.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      home: ModelViewer(
    src: "lib/assets/animations/squirrel_animation.glb",
  )));
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AccountInitDb().isEmpty(),
        builder: (context, snapshot) {
          Widget widget;

          if (snapshot.hasData && snapshot.data == false) {
            widget = Container(
              width: 200,
              height: 350,
              decoration: BoxDecoration(
                color: Color(0xFFFFEAC5),
                border: Border.all(color: Color(0xFFFFC45B), width: 3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF6E5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      child: FutureBuilder(
                        future: AnimalBackbone().animation(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ModelViewer(
                              src: snapshot.data!,
                            );
                          } else {
                            return Image(image: AssetImage(Froggo.bodyshot));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            widget = animalSelection();
          }
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, mainPage);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        border: Border.all(color: Color(0xFFFFC45B), width: 5),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.bookTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    decoration: TextDecoration.none,
                                    fontSize: 50),
                          ),
                          widget
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
