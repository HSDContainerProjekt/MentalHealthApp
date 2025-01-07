import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/friend_collection/widgets/month_view.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';

class FriendCollectionBirthdayCalender extends StatelessWidget {
  const FriendCollectionBirthdayCalender({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> months = [
      AppLocalizations.of(context)!.january,
      AppLocalizations.of(context)!.february,
      AppLocalizations.of(context)!.march,
      AppLocalizations.of(context)!.april,
      AppLocalizations.of(context)!.may,
      AppLocalizations.of(context)!.june,
      AppLocalizations.of(context)!.july,
      AppLocalizations.of(context)!.august,
      AppLocalizations.of(context)!.september,
      AppLocalizations.of(context)!.october,
      AppLocalizations.of(context)!.november,
      AppLocalizations.of(context)!.december,
    ];
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -4) {
            Navigator.pushNamed(context, friendsCollectionFriend);
          }
          if (details.delta.dx > 4) {
            Navigator.pushNamed(context, friendsCollectionMe);
          }
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(AppLocalizations.of(context)!.friendCollectionCalenderTitle,
                    style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, friendlist);
                    },
                    icon: Icon(Icons.person_add_alt_1))
              ],
            ),
            /*ListView.builder(
              itemCount: months.length,
              itemBuilder: (context, index){
                return MonthView(months.elementAt(index));
              },
            )*/
          ],
        ),
      )
    );
  }
}
