import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/database/ownID_db.dart';

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
      body: Column(children: [
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //do something
                        }
                      },
                      icon: Icon(Icons.check))
                ]))
      ]),
    );
  }
}
