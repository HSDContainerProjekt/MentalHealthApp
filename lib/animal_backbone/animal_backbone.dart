import 'dart:developer';

import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';
class AnimalBackbone {
  Future<String> animalType() async {
    var animalType;
    int ownId = await ownIdDB().getOwnIdAsInt();
    if (ownId == -1){
      animalType = await AccountInitDb().getOwnAnimalAsString();
    }
    else{
      var ownFriend = await FriendDB().fetchByID(ownId);
      if (ownFriend.animal != null || ownFriend.animal!.isNotEmpty) {
        animalType = ownFriend.animal;
      } else {
        animalType = await AccountInitDb().getOwnAnimalAsString();
      }
    }
    return animalType;
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

  Future<String> animation() async {
    switch (await animalType()) {
      case "froggo":
      log("called1");
        return Froggo.animation;
      case "maxie":
      log("called2");
        return Maxie.animation;
      default:
      log("called3");
        return Froggo.animation;
    }
  }

}