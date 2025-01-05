import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/bloc/image_selector_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/postit.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageSelectorBloc>(
      create: (_) => ImageSelectorBloc(),
      child: BlocBuilder<ImageSelectorBloc, ImageSelectorState>(
        builder: (context, state) {
          return PostIt(
            headline: "ImageSelector",
            mainBuilder: (context) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  floatingActionButton:
                      ElevatedButton(onPressed: () => 1 + 1, child: Text("+")),
                  body: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text("Test $index"),
                      );
                    },
                  ));
              // Bilder Liste Endlos Scrollable
            },
            buttons: [
              PostItButton(
                headline: "Abbrechen",
                onClick: () => 1 + 1,
              ),
              PostItButton(
                headline: "Bestätigen",
                onClick: () => 1 + 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
