import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/friend_db.dart';
import 'package:mental_health_app/friend_collection/database/online_database.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';
import 'package:mental_health_app/friend_collection/model/friend.dart';

import '../model/friendRequest.dart';

class FriendCollectionFriendlist extends StatefulWidget {
  const FriendCollectionFriendlist({super.key});

  @override
  State<FriendCollectionFriendlist> createState() =>
      _FriendCollectionFriendlistState();
}

class _FriendCollectionFriendlistState
    extends State<FriendCollectionFriendlist> {
  final myController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.friendListTitle,
                      style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: Icon(Icons.keyboard_backspace_rounded))
                ],
              )),
          FutureBuilder(
              future: ownIdDB().getOwnIdAsInt(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppLocalizations.of(context)!.myFriendID,
                            style: Theme.of(context).textTheme.displayLarge),
                        Text(snapshot.data.toString(),
                            style: Theme.of(context).textTheme.displayLarge)
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppLocalizations.of(context)!.myFriendID,
                            style: Theme.of(context).textTheme.displayLarge)
                      ],
                    ),
                  );
                }
              }),
          Container(
              padding: EdgeInsets.all(12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addFriend,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Expanded(
                        child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: myController,
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .missingValueError;
                                }
                              },
                            ))),
                    IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await OnlineDatabase().createFriendRequest(
                                await ownIdDB().getOwnIdAsInt(),
                                int.parse(myController.text));
                          }
                        },
                        icon: Icon(Icons.check))
                  ])),
          Text(AppLocalizations.of(context)!.friendCollectionFriendRequests,
                            style: Theme.of(context).textTheme.titleLarge),
          FutureBuilder<List<FriendRequest>>(
            future: OnlineDatabase().getOwnFriendRequests(),
            builder: (context, snapshot) {
              List<FriendRequest>? list;
              if (!snapshot.hasData || (list = snapshot.data)!.isEmpty) {
                return Text(AppLocalizations.of(context)!.noFriendRequests);
              } else {
                return ListView.builder(
                  primary: false,
                  padding: EdgeInsets.all(2),
                  shrinkWrap: true,
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    FriendRequest item = list![index];
                    return FriendRequestWidget(friendRequest: item);
                  },
                );
              }
            },
          ),
          Text(AppLocalizations.of(context)!.friendCollectionFriendTitle,
                            style: Theme.of(context).textTheme.titleLarge),
          FutureBuilder<List<Friend>>(
            future: FriendDB().getFriends(),
            builder: (context, snapshot) {
              List<Friend>? list;
              if (!snapshot.hasData || (list = snapshot.data)!.isEmpty) {
                return Text(AppLocalizations.of(context)!.noFriends);
              } else {
                return ListView.builder(
                  primary: false,
                  padding: EdgeInsets.all(2),
                  shrinkWrap: true,
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    Friend item = list![index];
                    return FriendWidget(friend: item);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class FriendRequestWidget extends StatelessWidget {
  final FriendRequest friendRequest;

  const FriendRequestWidget({super.key, required this.friendRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(friendRequest.friend1.toString(),
              style: Theme.of(context).textTheme.displayLarge),
          IconButton(
            onPressed: () {
              OnlineDatabase().acceptFriendRequest(friendRequest.friend1);
            },
            icon: Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              OnlineDatabase().deleteFriendRequest(friendRequest.friend1);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class FriendWidget extends StatelessWidget {
  final Friend friend;

  const FriendWidget({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(friend.friendID.toString(),
              style: Theme.of(context).textTheme.displayLarge),
          Text(friend.name.toString(),
              style: Theme.of(context).textTheme.displayLarge),
          IconButton(
            onPressed: () {
              log("1");
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}