import 'package:SDZ/env.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/11 13:42
/// @Description: 日记打印
class WFLogUtil {
  static var _title = "WeFree-Log";
  static var _isDebug = true;
  static int _limitLength = 800;

  ///需要显示的tag
  static List<String> _tags = ["ALL"];//ALL表示打印所有标签，包括空标签
  // static List<String> _tags = ["wuwx"];

  static void init(
      {String title = '', bool isDebug = true, int limitLength = 800}) {
    _title = title;
    _isDebug = Env.envType != EnvType.EnvType_Release;
    _limitLength = limitLength;
  }

  //仅Debug模式可见
  static void d(dynamic obj, {String? tag}) {
    if (_isDebug) {
      _log(obj.toString(), tag: tag);
    }
  }

  static void v(dynamic obj, {String? tag}) {
    _log(obj.toString(), tag: tag);
  }

  static void _log(String msg, {String? tag}) {
    if (_tags.contains("ALL") || (tag != null && _tags.contains(tag))) {
      if (msg.length < _limitLength) {
        print(msg);
      } else {
        segmentationLog(msg);
      }
    }
    // else if (tag == null) {
    //   if (msg.length < _limitLength) {
    //     print(msg);
    //   } else {
    //     segmentationLog(msg);
    //   }
    // }
  }

  static void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }
}
