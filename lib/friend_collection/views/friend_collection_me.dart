import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionMe extends StatelessWidget {
  const FriendCollectionMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -8) {
            Navigator.pushNamed(context, friendsCollectionBirthdayCalender);
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                //Profilbild 
                Column() //Eigene Angaben 
              ],
            ),
            Row(
              children: [
                Container(), // Das ist mein(e) lieblings
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,   
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0
                        ),
                      ),
                      child: Icon(Icons.favorite),)
                    ], // Haarfarbe, Augenfarbe, Lieblingsfarbe 
                )
              ],
            )
          ],
        )
      )
    );
  }
}
