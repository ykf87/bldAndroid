// Flutter imports:
import 'package:flutter/material.dart';

/// @Description 功能描述 首页网格菜单模型
class GridMenuModel {
  String title;
  String image;


  /// 如果是本地资源图片,必须是svg格式
  bool isAssets;

  VoidCallback onTap;
  Widget? icon;

  VoidCallback? onLongTap;

  GridMenuModel({required this.title,required this.image,required this.onTap,required this.isAssets,this.icon,this.onLongTap});

}
