import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
    return Image.asset(
      "lib/assets/images/appSelectableImages/joggen.png",
      height: 150.0,
      width: 150.0,
    );
  }
}
