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
          if (snapshot.hasData && snapshot.data == false) {
            return Scaffold(
                body: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, mainPage);
              },
              child: Stack(children: <Widget>[
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
                    color: Colors.transparent,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFFC45B), width: 5),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.appTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            decoration: TextDecoration.none,
                          ),
                    ),
                    Container(
                      color: Color(0xFFFFEED6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 200,
                          height: 400,
                          child: FutureBuilder(
                            future: AnimalBackbone().animation(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ModelViewer(
                                  src: snapshot.data!,
                                );
                              } else {
                                return Image(
                                    image: AssetImage(Froggo.bodyshot));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ]),
            ));
          } else {
            return Scaffold(
              body: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/bookcover.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppLocalizations.of(context)!.appTitle),
                    animalSelection(),
                    //Bild des Charakters der Person, default = Appmaskottchen
                    Text("Name der Person")
                    //Name der Person aus Datenbank ziehen, default = leer
                  ],
                ))
              ]),
            );
          }
        });
  }
}
