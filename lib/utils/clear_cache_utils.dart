import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/utils/wf_log_util.dart';

class ClearCacheUtils {
 static var _tempDir;

  ///加载缓存
  static Future<String?> loadCache() async {
    try {
      _tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(_tempDir);
      String  _cacheSize = _renderSize(value);
      return _cacheSize;
    } catch (err) {
      WFLogUtil.d(err);
    }
  }

  /// 递归方式 计算文件的大小
 static Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      WFLogUtil.d(e);
      return 0;
    }
  }

  ///递归方式删除目录
 static  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      WFLogUtil.d(e);
    }
  }

  ///格式化文件大小
 static _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = []..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }


  ///清除缓存
 static Future<Void?> clearCache() async {
   //此处展示加载loading
    try {
      _tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(_tempDir);
      if (value <= 0) {
          ToastUtils.toast('暂无可清除的缓存');
      } else if (value >= 0) {
        ToastUtils.toast('正在清除缓存..');
        Future.delayed(Duration(seconds: 2), () async {
          //删除缓存目录
          await delDir(_tempDir);
          await loadCache();

        });
        new Timer(Duration(seconds: 2), (){
          ToastUtils.toast('缓存清除完成');
        });

      }
    } catch (e) {
      WFLogUtil.d(e);
    } finally {}
  }
}
