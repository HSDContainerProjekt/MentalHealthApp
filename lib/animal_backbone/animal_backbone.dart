import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mental_health_app/friend_collection/database/account_init_DB.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/software_backbone/constants/animal.dart';

class AnimalBackbone {
  Future<String> animalType() async {
    var animalType;
    var ownFriend = await FriendDB().fetchByID(await ownIdDB().getOwnIdAsInt());
    if (ownFriend.animal != null || ownFriend.animal!.isNotEmpty) {
      animalType = ownFriend.animal;
    } else {
      animalType = await AccountInitDb().getOwnAnimalAsString();
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
}
