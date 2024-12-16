import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            Image(image: AssetImage("lib/assets/images/froggo_bodyshot.png"),), //Bild des Charakters der Person, default = Appmaskottchen
            Text(
                "Name der Person") //Name der Person aus Datenbank ziehen, default = leer
          ],
        ))
      ]),
    ));
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