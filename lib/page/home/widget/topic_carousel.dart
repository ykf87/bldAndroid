// Dart imports:

// Package imports:
import 'dart:ffi';

import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/page/menu/about.dart';
import 'package:SDZ/widget/SwiperPagination.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart'
    as my_carousel_comp;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

// Project imports:

/// 首頁輪播圖
class IndexTopicComponentCarousel extends StatelessWidget {
  final List<String> list;
  final double aspectRatio;

  const IndexTopicComponentCarousel({Key? key, required this.list,this.aspectRatio = 2.53})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            final item = list[index];
            return renderItem(item);
          },
          itemCount: list.length,
          pagination:  MySwiperPagination(),
          onTap: (int index) async {
            final item = list[index];

          },
        ),
      ),
    );
  }


  Widget renderItem(String item) {
    return Builder(
      builder: (BuildContext context) {
        return ExtendedImage.network(
          item,
          fit: BoxFit.fitWidth,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          shape: BoxShape.rectangle,
        );
      },
    );
  }

  CarouselSlider buildCarouselSlider(
      List<String> carousel, BuildContext context) {
    return CarouselSlider(
      options:
          CarouselOptions(height: 200, autoPlay: true, enlargeCenterPage: true),
      items: carousel.map(renderItem).toList(),
    );
  }
}
