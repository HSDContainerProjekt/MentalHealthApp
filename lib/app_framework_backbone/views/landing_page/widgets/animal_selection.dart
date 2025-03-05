import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class animalSelection extends StatelessWidget {
  const animalSelection({super.key});

  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            Text(AppLocalizations.of(context)!.animalSelection),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectableAvatar(
                  url: "lib/assets/images/froggo_portrait.png",
                  animal: "froggo",
                ),
                SelectableAvatar(
                  url: "lib/assets/images/character_placeholder1.jpeg",
                  animal: "maxie",
                )
              ],
            )
          ]),
        ));
  }
}

class SelectableAvatar extends StatefulWidget {
  const SelectableAvatar({Key? key, required this.url, required this.animal})
      : super(key: key);
  final String url;
  final String animal;

  @override
  State<SelectableAvatar> createState() => _SelectableAvatarState();
}

class _SelectableAvatarState extends State<SelectableAvatar> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        child: Builder(builder: (context) {
          final FocusNode focusNode = Focus.of(context);
          final bool hasFocus = focusNode.hasFocus;
          return GestureDetector(
            onTap: () {
              if (hasFocus) {
                AccountInitDb().create(widget.animal);
                Navigator.pushNamed(context, mainPage);
              } else {
                focusNode.requestFocus();
              }
            },
            child: _renderAvatar(hasFocus, widget.url),
          );
        }),
      ),
    );
  }

  Widget _renderAvatar(bool hasFocus, String image) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: hasFocus ? 120 : 100,
      height: hasFocus ? 120 : 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: hasFocus ? 5 : 3,
          color: hasFocus ? Colors.blue : Colors.black,
        ),
      ),
      child: CircleAvatar(
          backgroundImage: AssetImage(image),
          foregroundImage:
              hasFocus ? AssetImage("lib/assets/images/check.png") : null),
    );
  }
}
