import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../custom_image/image_repository.dart';
import '../../../custom_image/picture.dart';

part 'image_selector_event.dart';

part 'image_selector_state.dart';

class ImageSelectorBloc extends Bloc<ImageSelectorEvent, ImageSelectorState> {
  final ImageRepository imageRepository;

  int id = 0;

  ImageSelectorBloc(this.imageRepository) : super(ImageSelectorInitial()) {
    on<ImageSelectorLoadImageIDList>(_loadIDList);
    on<ImageSelectorAddImage>(_addImage);
    on<ImageSelectorSelectId>(_selectID);
  }

  Future<void> _loadIDList(
    ImageSelectorLoadImageIDList event,
    Emitter<ImageSelectorState> emit,
  ) async {
    emit(ImageSelectorLoading());
    emit(ImageSelectorLoaded(
        imageIDs: await imageRepository.availableIDs(), selectedImageId: id));
  }

  Future<void> _addImage(
    ImageSelectorAddImage event,
    Emitter<ImageSelectorState> emit,
  ) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
          ]);
      if (croppedFile == null) return;
      imageRepository.upsert(Picture(
          altText: "Not available", data: await croppedFile.readAsBytes()));
      add(ImageSelectorLoadImageIDList());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _selectID(
    ImageSelectorSelectId event,
    Emitter<ImageSelectorState> emit,
  ) async {
    id = event.id;
    if (state is ImageSelectorLoaded) {
      emit(ImageSelectorLoaded(
          imageIDs: (state as ImageSelectorLoaded).imageIDs,
          selectedImageId: id));
    }
  }
}
