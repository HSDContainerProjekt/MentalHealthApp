import 'package:flutter/material.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/app_framework_backbone/views/landing_page/widgets/animal_selection.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AccountInitDb().isEmpty(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Scaffold(
                body: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, mainPage);
              },
              child: Stack(children: <Widget>[
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
                    animalSelection(), //Bild des Charakters der Person, default = Appmaskottchen
                    Text(
                        "Name der Person") //Name der Person aus Datenbank ziehen, default = leer
                  ],
                ))
              ]),
            ));
          } else {
            return Scaffold(
                body: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, mainPage);
              },
              child: Stack(children: <Widget>[
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
                    FutureBuilder(
                        future: AnimalBackbone().bodyshot(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image(image: AssetImage(snapshot.data!));
                          } else {
                            return Image(
                              image: AssetImage(Froggo.bodyshot),
                            );
                          }
                        }), //Bild des Charakters der Person, default = Appmaskottchen
                    Text(
                        "Name der Person") //Name der Person aus Datenbank ziehen, default = leer
                  ],
                ))
              ]),
            ));
          }
          ;
        });
  }
}


/**
 * 
 *         GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            Navigator.pushNamed(context, appFrameworkPage);
          },
        ),
 */