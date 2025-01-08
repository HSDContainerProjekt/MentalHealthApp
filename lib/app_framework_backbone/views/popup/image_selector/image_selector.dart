import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/image_selector/bloc/image_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/popup/postit.dart';

import 'bloc/image_selector_bloc.dart';
import 'image_repository.dart';

class ImageSelector extends StatelessWidget {
  final int lastSelectedID;

  const ImageSelector({super.key, required this.lastSelectedID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageSelectorBloc>(
      create: (_) => ImageSelectorBloc(context.read<ImageRepository>())
        ..add(ImageSelectorSelectId(id: lastSelectedID))
        ..add(ImageSelectorLoadImageIDList()),
      child: BlocBuilder<ImageSelectorBloc, ImageSelectorState>(
        builder: (context, state) {
          return PostIt(
            headline: "ImageSelector",
            mainBuilder: (context) {
              if (state is ImageSelectorLoading) {
                return CircularProgressIndicator();
              }
              if (state is ImageSelectorLoaded) {
                return Scaffold(
                    backgroundColor: Colors.transparent,
                    floatingActionButton: ElevatedButton(
                        onPressed: () => context
                            .read<ImageSelectorBloc>()
                            .add(ImageSelectorAddImage()),
                        child: Text("+")),
                    body: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1, crossAxisCount: 2),
                      itemCount: state.imageIDs.length,
                      itemBuilder: (context, index) {
                        return _Image(
                          imageID: state.imageIDs[index],
                          isSelected:
                              state.imageIDs[index] == state.selectedImageId,
                        );
                      },
                    ));
              }
              return Text("Something went wrong");
            },
            buttons: [
              PostItButton(
                headline: "Abbrechen",
                onClick: () => Navigator.pop(context),
              ),
              PostItButton(
                headline: "Bestätigen",
                onClick: () => Navigator.pop(
                    context, context.read<ImageSelectorBloc>().id),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final int imageID;
  final bool isSelected;

  const _Image({super.key, required this.imageID, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<ImageSelectorBloc>()
          .add(ImageSelectorSelectId(id: imageID)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(
              width: isSelected ? 5 : 3,
              color: isSelected ? Colors.black : Colors.black12),
        ),
        child: BlocProvider(
          create: (_) => ImageBloc(
              imageRepository: context.read<ImageRepository>(),
              isSelected: isSelected)
            ..add(ImageEventLoadImage(id: imageID)),
          child: BlocBuilder<ImageBloc, ImageState>(
            builder: (BuildContext context, ImageState state) {
              if (state is ImageLoaded) {
                return Center(child: state.image);
              }
              if (state is ImageLoading) {
                return CircularProgressIndicator();
              }
              return Text("Something went wrong");
            },
          ),
        ),
      ),
    );
  }
}
