import 'package:async/async.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

Future<Friend> getOwnFriendDataAndTryToPUpdate() async {
  int ownId = await ownIdDB().getOwnIdAsInt();
  Friend ownFriend = await FriendDB().fetchByID(ownId);
  if (await OnlineDatabase().connected()) {
    OnlineDatabase().updateFriend(ownFriend);
  }
  return ownFriend;
}
