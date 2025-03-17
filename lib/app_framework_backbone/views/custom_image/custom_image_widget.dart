import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/image_bloc.dart';
import 'image_repository.dart';

class CustomImageWidget extends StatelessWidget {
  final int imageID;

  const CustomImageWidget({super.key, required this.imageID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      bloc: ImageBloc(
          imageRepository: context.read<ImageRepository>(), imageID: imageID),
      builder: (context, state) {
        if (state is ImageLoading) return CircularProgressIndicator();
        if (state is ImageLoaded) {
          return Image.memory(state.picture.data);
        }
        return Text("Something went wrong");
      },
    );
  }
}
