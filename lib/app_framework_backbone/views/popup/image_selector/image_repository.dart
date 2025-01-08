import 'package:flutter/widgets.dart';

import 'picture.dart';
import 'image_dao.dart';

class ImageRepository {
  final Map<int, String> appImages = {
    0: "lib/assets/images/appSelectableImages/drinking.png",
    -1: "lib/assets/images/appSelectableImages/drinking.png",
    -2: "lib/assets/images/appSelectableImages/joggen.png"
  };

  final ImageDAO imageDAO;

  ImageRepository({required this.imageDAO});

  Future<Image> imageBy(int imageID) async {
    if (imageID > 0) {
      return Image.memory((await imageDAO.imageBy(imageID)).data);
    } else {
      if (appImages.containsKey(imageID)) {
        return Image.asset(appImages[imageID]!);
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
