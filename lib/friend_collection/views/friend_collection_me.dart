import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';
import 'package:mental_health_app/friend_collection/widgets/formfield_personalinformation_widget.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/widgets/custom_color_widget.dart';
import 'package:mental_health_app/friend_collection/widgets/formfield_favorit_widget.dart';

class FriendCollectionMe extends StatelessWidget {
  const FriendCollectionMe({super.key});

  @override
  Widget build(BuildContext context) {
    final _myFavoriteformKey = GlobalKey<FormState>();
    final _myInformationformKey = GlobalKey<FormState>();
    
    EdgeInsets paddingvalue = EdgeInsets.all(6);
    
    return FutureBuilder(
      future: DatabaseOperation().getOwnFriendDataAndTryToUpdate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var ownData = snapshot.data;
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white70,
                  body: GestureDetector(
                      onPanUpdate: (details) {
                        if (details.delta.dx < -4) {
                          Navigator.pushNamed(
                              context, friendsCollectionBirthdayCalender);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DottedBorder(
                              color: Colors.black,
                              child: Row(
                                children: [
                                  Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: FutureBuilder(future: AnimalBackbone().portrait(), builder:(context, snapshot) {
                                        if(snapshot.hasData){
                                          return Image(image: AssetImage(snapshot.data!));
                                        }
                                        else {
                                          return Image(image: AssetImage(Froggo.portrait));
                                        }
                                      }),
                                    ),
                                    FormBuilder(
                                      key:
                                          _myInformationformKey, // GlobalKey<FormState>
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: <Widget>[
                                          FormfieldPersonalinformationWidget(
                                              "name", ownData?.name ?? ''),
                                          FormfieldPersonalinformationWidget(
                                              "nickname", ownData?.nickname ?? ''),
                                          FormfieldPersonalinformationWidget(
                                              "birthday", ownData?.birthday ?? ''),
                                          FormfieldPersonalinformationWidget(
                                              "zodiacsign", ownData?.zodiacSign ?? ''),
                                        ],
                                      ),
                                    )
                                  ])
                                ],
                              )),
                          IntrinsicHeight(
                              child: Row(
                            children: [
                              DottedBorder(
                                  color: Colors.black,
                                  padding: paddingvalue,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .headlineFavoriteBox)
                                        ],
                                      ),
                                      FormBuilder(
                                        key:
                                            _myFavoriteformKey, // GlobalKey<FormState>
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: <Widget>[
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteSong,
                                                ownData?.favoriteSong ?? '',
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteFood,
                                                ownData?.favoriteFood ?? '',
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteBook,
                                                ownData?.favoriteBook ?? '',
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteMovie,
                                                ownData?.favoriteFilm ?? '',
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteAnimal,
                                                ownData?.favoriteAnimal ?? '',
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteNumber,
                                                ownData?.favoriteNumber.toString() ?? '',
                                                "textFieldHint"),
                                          ],
                                        ),
                                      )
                                    ],
                                  )), // Das ist mein(e) lieblings
                              IntrinsicWidth(
                                  child: Padding(
                                      padding: paddingvalue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CustomColorWidget(Icons.remove_red_eye_outlined,AppLocalizations.of(context)!.eyeColor), // Augenfarbe,
                                          CustomColorWidget(Icons.favorite, AppLocalizations.of(context)!.hairColor),
                                          CustomColorWidget(Icons.color_lens,AppLocalizations.of(context)!.favoriteColor)
                                        ],
                                      )))
                            ],
                          ))
                        ],
                      ))));
        } else {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white70,
                  body: GestureDetector(
                      onPanUpdate: (details) {
                        if (details.delta.dx < -4) {
                          Navigator.pushNamed(
                              context, friendsCollectionBirthdayCalender);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DottedBorder(
                              color: Colors.black,
                              child: Row(
                                children: [
                                  Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: FutureBuilder(future: AnimalBackbone().portrait(), builder:(context, snapshot) {
                                        if(snapshot.hasData){
                                          return Image(image: AssetImage(snapshot.data!));
                                        }
                                        else {
                                          return Image(image: AssetImage(Froggo.portrait));
                                        }
                                      })
                                    ),
                                    FormBuilder(
                                      key:
                                          _myInformationformKey, // GlobalKey<FormState>
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: <Widget>[
                                          FormfieldPersonalinformationWidget(
                                              "name", "name"),
                                          FormfieldPersonalinformationWidget(
                                              "", "name"),
                                          FormfieldPersonalinformationWidget(
                                              "name", "name"),
                                          FormfieldPersonalinformationWidget(
                                              "name", "name"),
                                        ],
                                      ),
                                    )
                                  ])
                                ],
                              )),
                          IntrinsicHeight(
                              child: Row(
                            children: [
                              DottedBorder(
                                  color: Colors.black,
                                  padding: paddingvalue,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .headlineFavoriteBox)
                                        ],
                                      ),
                                      FormBuilder(
                                        key:
                                            _myFavoriteformKey, // GlobalKey<FormState>
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: <Widget>[
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteSong,
                                                "",
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteFood,
                                                "",
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteBook,
                                                "",
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteMovie,
                                                "",
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteAnimal,
                                                "",
                                                "textFieldHint"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteNumber,
                                                "",
                                                "textFieldHint"),
                                          ],
                                        ),
                                      )
                                    ],
                                  )), // Das ist mein(e) lieblings
                              IntrinsicWidth(
                                  child: Padding(
                                      padding: paddingvalue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CustomColorWidget(Icons.remove_red_eye_outlined,AppLocalizations.of(context)!.eyeColor), // Augenfarbe,
                                          CustomColorWidget(Icons.favorite, AppLocalizations.of(context)!.hairColor),
                                          CustomColorWidget(Icons.color_lens,AppLocalizations.of(context)!.favoriteColor)
                                        ],
                                      )))
                            ],
                          ))
                        ],
                      ))));
        }
      },
    );
  }
}
