import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name,
      {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name,
      {ImageFormat format = ImageFormat.png}) {
    if (format == ImageFormat.png) {
      return 'assets/images/$name.png';
    } else if (format == ImageFormat.jpg) {
      return 'assets/images/$name.jpg';
    } else if (format == ImageFormat.webp) {
      return 'assets/images/$name.webp';
    } else if (format == ImageFormat.gif) {
      return 'assets/images/$name.gif';
    } else {
      return "";
    }
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg = 'none'}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImgPath('iv_default_head'));
    }
    return CachedNetworkImageProvider(imageUrl);
  }
}

enum ImageFormat { png, jpg, gif, webp }
