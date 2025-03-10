import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/widgets/formfield_date_picker.dart';
import 'package:mental_health_app/friend_collection/widgets/formfield_personalinformation_widget.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/widgets/custom_color_widget.dart';
import 'package:mental_health_app/friend_collection/widgets/formfield_favorit_widget.dart';

class FriendCollectionMe extends StatefulWidget {
  const FriendCollectionMe({super.key});

  @override
  _FriendCollectionMeState createState() => _FriendCollectionMeState();
}

class _FriendCollectionMeState extends State<FriendCollectionMe> {
  late Future<Friend> friendDataFuture;

  @override
  void initState() {
    super.initState();
    friendDataFuture = DatabaseOperation().getOwnFriendDataAndTryToUpdate();
  }


  @override
  Widget build(BuildContext context) {
    final myFavoriteformKey = GlobalKey<FormState>();
    final myInformationformKey = GlobalKey<FormState>();
    EdgeInsets paddingvalue = EdgeInsets.all(6);

    return FutureBuilder<Friend>(
      future: DatabaseOperation().getOwnFriendDataAndTryToUpdate(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(child: Text("waiting"));
        }
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
                                      child: FutureBuilder(
                                          future: AnimalBackbone().portrait(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Image(
                                                  image: AssetImage(
                                                      snapshot.data!));
                                            } else {
                                              return Image(
                                                  image: AssetImage(
                                                      Froggo.portrait));
                                            }
                                          }),
                                    ),
                                    FormBuilder(
                                      key:
                                          myInformationformKey, // GlobalKey<FormState>
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: <Widget>[
                                          FormfieldPersonalinformationWidget(
                                              "name",
                                              ownData?.name ?? '',
                                              "name"),
                                          FormfieldPersonalinformationWidget(
                                              "nickname",
                                              ownData?.nickname ?? '',
                                              "nickname"),
                                          FormfieldPersonalinformationWidget(
                                              "birthday",
                                              ownData?.birthday ?? '',
                                              "birthday"),
                                          FormfieldPersonalinformationWidget(
                                              "zodiacsign",
                                              ownData?.zodiacSign ?? '',
                                              "zodiacSign"),
                                        ],
                                      ),
                                    )
                                  ]),
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
                                            myFavoriteformKey, // GlobalKey<FormState>
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: <Widget>[
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteSong,
                                                ownData?.favoriteSong ?? '',
                                                "textFieldHint",
                                                "favoriteSong"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteFood,
                                                ownData?.favoriteFood ?? '',
                                                "textFieldHint",
                                                "favoriteFood"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteBook,
                                                ownData?.favoriteBook ?? '',
                                                "textFieldHint",
                                                "favoriteBook"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteMovie,
                                                ownData?.favoriteFilm ?? '',
                                                "textFieldHint",
                                                'favoriteFilm'),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteAnimal,
                                                ownData?.favoriteAnimal ?? '',
                                                "textFieldHint",
                                                'favoriteAnimal'),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteNumber,
                                                ownData?.favoriteNumber
                                                        .toString() ??
                                                    '',
                                                "textFieldHint",
                                                'favoriteNumber'),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              IntrinsicWidth(
                                  child: Padding(
                                      padding: paddingvalue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CustomColorWidget(
                                              Icons.remove_red_eye_outlined,
                                              AppLocalizations.of(context)!
                                                  .eyeColor), // Augenfarbe,
                                          CustomColorWidget(
                                              Icons.favorite,
                                              AppLocalizations.of(context)!
                                                  .hairColor),
                                          CustomColorWidget(
                                              Icons.color_lens,
                                              AppLocalizations.of(context)!
                                                  .favoriteColor)
                                        ],
                                      ))),
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
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: FutureBuilder(
                                            future: AnimalBackbone().portrait(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Image(
                                                    image: AssetImage(
                                                        snapshot.data!));
                                              } else {
                                                return Image(
                                                    image: AssetImage(
                                                        Froggo.portrait));
                                              }
                                            })),
                                    FormBuilder(
                                      key:
                                          myInformationformKey, // GlobalKey<FormState>
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: <Widget>[
                                          FormfieldPersonalinformationWidget(
                                              "name", '', "name"),
                                          FormfieldPersonalinformationWidget(
                                              "nickname", '', "nickname"),
                                          FormfieldDatePicker("birthday"),
                                          FormfieldPersonalinformationWidget(
                                              "zodiacsign", '', "zodiacSign"),
                                        ],
                                      ),
                                    )
                                  ]),
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
                                            myFavoriteformKey, // GlobalKey<FormState>
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: <Widget>[
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteSong,
                                                '',
                                                "textFieldHint",
                                                "favoriteSong"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteFood,
                                                '',
                                                "textFieldHint",
                                                "favoriteFood"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteBook,
                                                '',
                                                "textFieldHint",
                                                "favoriteBook"),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteMovie,
                                                '',
                                                "textFieldHint",
                                                'favoriteFilm'),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteAnimal,
                                                '',
                                                "textFieldHint",
                                                'favoriteAnimal'),
                                            FormfieldFavoritWidget(
                                                AppLocalizations.of(context)!
                                                    .favoriteNumber,
                                                '',
                                                "textFieldHint",
                                                'favoriteNumber'),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              IntrinsicWidth(
                                  child: Padding(
                                      padding: paddingvalue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CustomColorWidget(
                                              Icons.remove_red_eye_outlined,
                                              AppLocalizations.of(context)!
                                                  .eyeColor), // Augenfarbe,
                                          CustomColorWidget(
                                              Icons.favorite,
                                              AppLocalizations.of(context)!
                                                  .hairColor),
                                          CustomColorWidget(
                                              Icons.color_lens,
                                              AppLocalizations.of(context)!
                                                  .favoriteColor)
                                        ],
                                      ))),
                            ],
                          ))
                        ],
                      ))));
        }
      },
    );
  }
}
