import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'picture.dart';
import 'image_dao.dart';

class ImageRepository {
  final Map<int, String> appImages = {
    0: "lib/assets/images/squirrel_images/squirrel_default.png",
    -1: "lib/assets/images/squirrel_images/squirrel_default_closeup.png",
    -2: "lib/assets/images/squirrel_images/squirrel_drinking.png",
    -3: "lib/assets/images/squirrel_images/squirrel_drinking_closeup.png",
    -4: "lib/assets/images/squirrel_images/squirrel_flowers.png",
    -5: "lib/assets/images/squirrel_images/squirrel_flowers_distance.png",
    -6: "lib/assets/images/squirrel_images/squirrel_full_body.png",
    -7: "lib/assets/images/squirrel_images/squirrel_waving.png",
    -8: "lib/assets/images/frog_images/frog_default.png",
    -9: "lib/assets/images/frog_images/frog_default_closeup.png",
    -10: "lib/assets/images/frog_images/frog_drinking.png",
    -11: "lib/assets/images/frog_images/frog_drinking_closeup.png",
    -12: "lib/assets/images/frog_images/frog_flowers.png",
    -13: "lib/assets/images/frog_images/frog_flowers_distance.png",
    -14: "lib/assets/images/frog_images/frog_full_body.png",
    -15: "lib/assets/images/frog_images/frog_waving.png",
  };

  final ImageDAO imageDAO;

  ImageRepository({required this.imageDAO});

  Future<Picture> imageBy(int imageID) async {
    if (imageID > 0) {
      return imageDAO.imageBy(imageID);
    } else {
      if (appImages.containsKey(imageID)) {
        return Picture(
            data: (await rootBundle.load(appImages[imageID]!))
                .buffer
                .asUint8List(),
            altText: "");
      } else {
        throw Exception("Image not found");
      }
    }
  }

  Future<int> upsert(Picture newPicture) {
    return imageDAO.upsert(newPicture);
  }

  Future<List<int>> availableIDs() async {
    List<int> result = await imageDAO.idList();
    result.addAll(appImages.keys);
    return result;
  }
}
