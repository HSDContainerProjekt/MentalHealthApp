import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/friend_collection/database/account_init_db.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/own_id_db.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';

class AnimalBackbone {
  Future<String> animalType() async {
    var animalType;
    int ownId = await ownIdDB().getOwnIdAsInt();
    if (ownId == -1) {
      animalType = await AccountInitDb().getOwnAnimalAsString();
    } else {
      var ownFriend = await FriendDB().fetchByID(ownId);
      if (ownFriend.animal != null || ownFriend.animal!.isNotEmpty) {
        animalType = ownFriend.animal;
      } else {
        animalType = await AccountInitDb().getOwnAnimalAsString();
      }
    }
    return animalType;
  }

  Future<String> icon() async {
    switch (await animalType()) {
      case "froggo":
        return Froggo.icon;
      case "maxie":
        return Maxie.icon;
      default:
        return Froggo.icon;
    }
  }

  Future<String> bodyshot() async {
    switch (await animalType()) {
      case "froggo":
        return Froggo.bodyshot;
      case "maxie":
        return Maxie.bodyshot;
      default:
        return Froggo.bodyshot;
    }
  }

  Future<String> portrait() async {
    switch (await animalType()) {
      case "froggo":
        return Froggo.portrait;
      case "maxie":
        return Maxie.portrait;
      default:
        return Froggo.portrait;
    }
  }

  Future<String> friendPortrait(String animal) async {
    switch (animal) {
      case "froggo":
        return Froggo.portrait;
      case "maxie":
        return Maxie.portrait;
      default:
        return Froggo.portrait;
    }
  }

  Future<String> animation() async {
    switch (await animalType()) {
      case "froggo":
        return Froggo.animation;
      case "maxie":
        return Maxie.animation;
      default:
        return Froggo.animation;
    }
  }
}
