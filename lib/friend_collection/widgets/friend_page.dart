import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/animal_backbone/animal_backbone.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';
import 'package:mental_health_app/friend_collection/widgets/friendpage_widgets/friend_color_widget.dart';
import 'package:mental_health_app/friend_collection/widgets/friendpage_widgets/friend_favorit_widget.dart';
import 'package:mental_health_app/friend_collection/widgets/friendpage_widgets/friend_personal_information_widget.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendPage extends StatelessWidget {
  final Friend friend;

  static const EdgeInsets paddingvalue = EdgeInsets.all(4.0);

  const FriendPage({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white70,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DottedBorder(
                    color: Colors.black,
                    child: Row(
                      children: [
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: FutureBuilder(
                                future: AnimalBackbone().portrait(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image(
                                        image: AssetImage(snapshot.data!));
                                  } else {
                                    return Image(
                                        image: AssetImage(Froggo.portrait));
                                  }
                                }),
                          ),
                          FormBuilder(
                            child: Column(
                              children: <Widget>[
                                FriendPersonalinformationWidget(
                                  "name",
                                  friend.name ?? '',
                                ),
                                FriendPersonalinformationWidget(
                                    "nickname", friend.nickname ?? ''),
                                FriendPersonalinformationWidget(
                                    "birthday", friend.birthday ?? ''),
                                FriendPersonalinformationWidget(
                                    "zodiacsign", friend.zodiacSign ?? ''),
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
                              child: Column(
                                children: <Widget>[
                                  FriendFavoritWidget(
                                      AppLocalizations.of(context)!
                                          .favoriteSong,
                                      friend.favoriteSong ?? ''),
                                  FriendFavoritWidget(
                                      AppLocalizations.of(context)!
                                          .favoriteFood,
                                      friend.favoriteFood ?? ''),
                                  FriendFavoritWidget(
                                      AppLocalizations.of(context)!
                                          .favoriteBook,
                                      friend.favoriteBook ?? ''),
                                  FriendFavoritWidget(
                                      AppLocalizations.of(context)!
                                          .favoriteMovie,
                                      friend.favoriteFilm ?? ''),
                                  FriendFavoritWidget(
                                    AppLocalizations.of(context)!
                                        .favoriteAnimal,
                                    friend.favoriteAnimal ?? '',
                                  ),
                                  FriendFavoritWidget(
                                    AppLocalizations.of(context)!
                                        .favoriteNumber,
                                    friend.favoriteNumber.toString(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )), // Das ist mein(e) lieblings
                    IntrinsicWidth(
                        child: Padding(
                            padding: paddingvalue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FriendColorWidget(
                                    Icons.remove_red_eye_outlined,
                                    AppLocalizations.of(context)!.eyeColor,
                                    Color(friend.eyecolor ??
                                        4280391411)), // Augenfarbe,
                                FriendColorWidget(
                                    Icons.favorite,
                                    AppLocalizations.of(context)!.hairColor,
                                    Color(friend.hairColor ?? 4280391411)),
                                FriendColorWidget(
                                    Icons.color_lens,
                                    AppLocalizations.of(context)!.favoriteColor,
                                    Color(friend.favoriteColor ?? 4280391411))
                              ],
                            )))
                  ],
                ))
              ],
            )));
  }
}
