import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:SDZ/core/utils/toast.dart';

class ShowLargeImage extends StatelessWidget {
  ShowLargeImage(this.image);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            color: Colors.black,
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              child: image,
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 20,
          child: FlatButton(
            padding: EdgeInsets.zero,
            color: Colors.black12,
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FlatButton(
            padding: EdgeInsets.zero,
            color: Colors.black12,
            child: Icon(
              Icons.download_sharp,
              color: Colors.white,
            ),
            onPressed: () => _saveImage(),
          ),
        ),
      ],
    );
  }

  _saveImage() async {
    await _permission((hasPermission) async {
      if (hasPermission) {
        SmartDialog.showLoading(msg: '存储中');
        ui.Image img = await _loadImageByProvider(image.image);
        ByteData? byteData = await img.toByteData(
          format: ui.ImageByteFormat.png,
        );
        if (byteData == null) return;
        Uint8List pngBytes = byteData.buffer.asUint8List();
        Directory tempDir = await getTemporaryDirectory();
        File? file = new File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
        print("===》" + file.path);
        if (!file.existsSync()) {
          file.createSync();
        }
        file.writeAsBytesSync(pngBytes); //写入文件

        var flag = await GallerySaver.saveImage(file.path);
//        print('result==$flag');
        if (flag == true) {
          ToastUtils.toast('保存成功');
        } else {
          ToastUtils.toast('保存失败');
        }

        SmartDialog.dismiss();

      } else {
        SmartDialog.showToast('没有权限');
      }
    });
  }

  _permission(callback(bool hasPermission)) async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        callback(true);
      } else {
        callback(false);
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        callback(true);
      } else {
        callback(false);
      }
    }
  }

  Future<ui.Image> _loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStreamListener? listener;
    ImageStream stream = provider.resolve(config);
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final ui.Image image = frame.image;
      completer.complete(image);
      if (listener != null) stream.removeListener(listener);
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }
}
