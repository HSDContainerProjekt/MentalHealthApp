import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../animal_backbone/animal_backbone.dart';
import '../../../software_backbone/constants/animal.dart';

enum Animal { froernchen, froggo }

enum Animation { idle, happy }

class MainPageAnimalState extends Equatable {
  final Animal animal;
  final Animation animation;

  MainPageAnimalState({required this.animal, required this.animation});

  @override
  List<Object?> get props => [animal, animation];

  String animalToString(BuildContext context) {
    switch (animal) {
      case Animal.froernchen:
        return "Frörnchen";
      case Animal.froggo:
        return "Froggo";
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
