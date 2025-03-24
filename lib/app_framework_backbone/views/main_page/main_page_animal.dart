import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../animal_backbone/animal_backbone.dart';

enum Animation { idle, happy }

class MainPageAnimalState extends Equatable {
  final String animalType;
  final Animation animation;

  const MainPageAnimalState(
      {required this.animalType, required this.animation});

  @override
  List<Object?> get props => [animation, animalType];

  String name(BuildContext context) {
    switch (animalType) {
      case "froggo":
        return AppLocalizations.of(context)!.froggo;
      case "maxie":
        return AppLocalizations.of(context)!.frornchen;
      default:
        return "";
    }
  }
}

class MainPageAnimal extends StatelessWidget {
  final MainPageAnimalState mainPageAnimalState;

  const MainPageAnimal({super.key, required this.mainPageAnimalState});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: FutureBuilder(
        future: AnimalBackbone().animation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ModelViewer(
              src: snapshot.data!,
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(50),
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
