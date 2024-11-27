import 'package:flutter/material.dart';
import 'package:mental_health_app/navigation_bar/navigation_bar.dart';
import 'package:mental_health_app/software_backbone/routing/router.dart'
    as App_router;
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'package:mental_health_app/software_backbone/themes/theme_constraints.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendCollection extends StatelessWidget {
  const FriendCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              
              decoration: BoxDecoration(
                image: DecorationImage( image: AssetImage("lib/assets/images/bookpage.jpg"), 
                                        fit: BoxFit.cover,),
              ),
            
              child: 
                Center(
                  child: 
                    Text(
                      AppLocalizations.of(context)!.friendCollectionTitle,
                      style: Theme.of(context).textTheme.displayLarge,                      
                    ),
                ),
            )
    );
  }
}