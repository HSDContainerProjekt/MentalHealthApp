import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../image_repository.dart';
import '../picture.dart';

part 'image_state.dart';

class ImageBloc extends Cubit<ImageState> {
  final ImageRepository imageRepository;
  final int imageID;

  ImageBloc({required this.imageRepository, required this.imageID})
      : super(ImageInitial()) {
    loadImage();
  }

  Future<void> loadImage() async {
    emit(ImageLoading());
    emit(ImageLoaded(picture: await imageRepository.imageBy(imageID)));
  }
}
