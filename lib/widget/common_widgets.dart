import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/utils/wf_log_util.dart';

//图片占位图,width和height设计稿上的宽和高
imgPlaceholder(
    double width, double height, double defaultImgW, double defaultImgH) {
  return Container(
      // color: Colors.red,
      width: sWidth(width),
      height: sWidth(height),
      child: Center(
        child: SvgPicture.asset(
          "assets/svg/loading.svg",
          width: sWidth(57.5),
          height: sWidth(32),
        ),
      ));
}

///imageUrl图片url，idth和height设计稿上的宽和高
imgWidget(String imageUrl, double width, double height, double defaultImgW,
    double defaultImgH) {

  double wPX = dpToPX(width);
  // double hPX = dpToPX(height);
  if (imageUrl.isNotEmpty) {
    imageUrl =
        imageUrl + "?x-oss-process=image/resize,w_" + wPX.toInt().toString();
  }
//  WFLogUtil.d("-------imageUrl--------" + imageUrl);
  Widget tImgWidget;
  if (imageUrl.isNotEmpty) {
    tImgWidget = CachedNetworkImage(
      fadeOutDuration: const Duration(milliseconds: 100),
      //动画时间久会有占位图到真实图片的渐变过程
      fadeInDuration: const Duration(milliseconds: 50),
      width: sWidth(width),
      height: sHeight(height),
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      //图片解码（decode）的用，如果不设置直接按照原图大小
      memCacheWidth: sWidth(width * 2).toInt(),
      memCacheHeight: sHeight(height * 2).toInt(),
      //cacheKey ?? url, scale, maxWidthDiskCache, maxHeightDiskCache，这几个维度决定磁盘缓存的key
      maxWidthDiskCache: sWidth(width * 2).toInt(),
      maxHeightDiskCache: sHeight(height * 2).toInt(),//
      placeholder: (context, url) =>
          imgPlaceholder(width, height, defaultImgW, defaultImgH),
      errorWidget: (context, url, error) =>
          imgPlaceholder(width, height, defaultImgW, defaultImgH),
    );
  } else {
    tImgWidget = Container(
      width: sWidth(width),
      height: sHeight(height),
      child: imgPlaceholder(width, height, defaultImgW, defaultImgH),
    );
  }
  return tImgWidget;
}

avatarPlaceholder(double avatarW) {
  return SvgPicture.asset(
    "assets/svg/ic_avatar.svg",
    width: sWidth(avatarW),
    height: sWidth(avatarW),
  );
}

///avatarW设计稿上的尺寸,比如在375上的尺寸
avatarWidget(String avatar, double avatarW) {
  double avatarWPX = dpToPX(avatarW);
  Widget tAvatarImg;
  if (avatar.isNotEmpty) {
    avatar = avatar +
        "?x-oss-process=image/resize,w_" +
        avatarWPX.toInt().toString();
    tAvatarImg = CachedNetworkImage(
      width: sWidth(avatarW),
      height: sWidth(avatarW),
      memCacheWidth: sWidth(avatarW * 2).toInt(),
      //设置avatarW，图片太模糊
      memCacheHeight: sWidth(avatarW * 2).toInt(),
      maxWidthDiskCache: sWidth(avatarW * 2).toInt(),
      maxHeightDiskCache: sHeight(avatarW * 2).toInt(),
      fit: BoxFit.cover,
      imageUrl: avatar,
      placeholder: (context, url) => avatarPlaceholder(avatarW),
      errorWidget: (context, url, error) => avatarPlaceholder(avatarW),
    );
  } else {
    tAvatarImg = avatarPlaceholder(avatarW);
  }
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(360)),
    child: tAvatarImg,
  );
}

double dpToPX(double dp) {
  return sWidth(dp) * ScreenUtil.getInstance().screenDensity;
}

double paintWidthWithTextStyle(TextStyle style, String text) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width;
}

///空视图
emptyWidget(String emptyText) {
  return Container(
    margin: EdgeInsets.only(top: sWidth(96)),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          SvgPath.ic_empty,
          width: sWidth(120),
          height: sWidth(120),
        ),
        Container(
          height: sWidth(20),
        ),
        Text(
          emptyText,
          style: TextStyle(
              fontSize: sWidth(14), color: Color.fromRGBO(106, 110, 126, 1)),
        ),
      ],
    ),
  );
}

double getAppBarTop() {
  return getStatusBarHeight();
}

double getStatusBarHeight() {
  return ScreenUtil.getInstance().statusBarHeight;
}

double getAppBarH() {
  return ScreenUtil.getInstance().appBarHeight;
}

//标题栏
appBar(String title, VoidCallback? _onTap) {
  return Container(
//     color: Colors.red,
    // color: Color.fromRGBO(16, 18, 26, 1),
    // color: Color.fromRGBO(16, 18, 26, 1),
    height: getAppBarH(),
    margin: EdgeInsets.only(top: getAppBarTop()),
    child: Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        IconButton(
            padding: EdgeInsets.only(left: sWidth(12)),
            onPressed: () {
              _onTap?.call();
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/svg/ic_back.svg",
              width: sWidth(22),
              height: sWidth(22),
            )),
        Center(
          child: Text(title,
              style: TextStyle(
                  fontSize: sFontSize(20), fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}

//红点
redDotWidget() {
  return Container(
    width: sWidth(8),
    height: sWidth(8),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(sWidth(15)),
      ),
    ),
  );
}

/// 未读数
unreadCoundWidget(int unreadCount) {
  if (unreadCount == 0) return Container();
  String count;
  if (unreadCount > 99) {
    count = '99+';
  } else {
    count = unreadCount.toString();
  }
  return Container(
    padding: EdgeInsets.only(left: sWidth(3), right: sWidth(3)),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(sWidth(15)),
      ),
    ),
    constraints: BoxConstraints(
      minWidth: sWidth(2),
      maxWidth: sWidth(10),
    ),
    child: Text(
      count,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: sFontSize(12),
        color: Colors.white,
      ),
    ),
  );
}

/**
 * 获取根据设计宽度和屏幕实际宽度计算后的宽度
 */
double sWidth(double size) {
  return ScreenUtil.getInstance().getWidth(size);
}

/**
 * 获取根据设计高度和屏幕实际告诉计算后的宽度
 */
double sHeight(double size) {
  return ScreenUtil.getInstance().getHeight(size);
}

/// 屏幕字体
double sFontSize(double size) {
  return ScreenUtil.getInstance().getSp(size);
  // return screen_util.ScreenUtil().setSp(size);
}

/// 根据毫秒返回时间Str
/// isAllShow是否任何情况都展示
/// showTime是否显示HH:mm
String timeStrByMs(int ms,
    {int previousMs = 0, bool isAllShow = false, bool showTime = false}) {
  String ret = '';
  // 是否当天
  // HH:mm
  if (DateUtil.isToday(ms)) {
    //isAllShow是否每条都展示时间,或者超过5分钟
    if (isAllShow || (ms - previousMs) > 5 * 60 * 1000) {
      ret = DateUtil.formatDateMs(ms, format: 'HH:mm');
    }
  }
  // // 是否本周
  // // 周一、周二、周三...
  // else if (DateUtil.isWeek(ms)) {
  //   ret = DateUtil.getWeekdayByMs(ms);
  // }

  // 是否本年
  // MM/dd
  else if (DateUtil.yearIsEqualByMs(ms, DateUtil.getNowDateMs())) {
    if (isAllShow || (ms - previousMs) > 5 * 60 * 1000) {
      if (showTime) {
        ret = DateUtil.formatDateMs(ms, format: 'MM-dd HH:mm');
      } else {
        ret = DateUtil.formatDateMs(ms, format: 'MM-dd');
      }
    }
  }
  // yyyy/MM/dd
  else {
    if (isAllShow || (ms - previousMs) > 5 * 60 * 1000) {
      if (showTime) {
        ret = DateUtil.formatDateMs(ms, format: 'yyyy-MM-dd HH:mm');
      } else {
        ret = DateUtil.formatDateMs(ms, format: 'yyyy-MM-dd');
      }
    }
  }

  return ret;
}

/// 时间转换string
