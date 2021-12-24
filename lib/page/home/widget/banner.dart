// Flutter imports:
// Package imports:
import 'dart:ffi';

import 'package:SDZ/entity/search/card_entity.dart';
import 'package:SDZ/page/home/widget/topic_carousel.dart';
import 'package:SDZ/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final carouselRiverpod = FutureProvider<List<String>>((ref) async {

  final result = await getCarousel();
  return result;
});
/// 获取轮播图
Future<List<String>> getCarousel() async {
  String image =  'https://img2.baidu.com/it/u=1729250424,3321747351&fm=26&fmt=auto';
  return  [image,image,image,image];
}
class IndexCarousel extends HookWidget {
  const IndexCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carousel = useProvider(carouselRiverpod);
    return carousel.when(
        data: (data) => IndexTopicComponentCarousel(
          list: data,
        ),
        loading: () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: const AspectRatio(
            aspectRatio: 2.53,
            child: Skeleton(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        error: (_, __) => const Text('加载轮播图失败'));
  }
}
