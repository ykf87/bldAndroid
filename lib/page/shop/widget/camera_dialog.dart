import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/double_click.dart';

class CameraDialog extends StatefulWidget {
  /// 是否裁剪
  final bool isCrop;

  final Function callBack;

  CameraDialog({Key? key, required this.callBack, this.isCrop = false})
      : super(key: key);
  @override
  _CameraDialog createState() => _CameraDialog();
}

class _CameraDialog extends State<CameraDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      child: Container(
          decoration: BoxDecoration(
              color: Colours.color_181A23,
              borderRadius: BorderRadius.circular((8))),
          height: 180.5,
          child: Column(
            children: <Widget>[
              DoubleClick(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.color_181A23,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8))),
                  width: double.infinity,
                  height: 60,
                  child: Center(
                      child: Text("拍照",
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                ),
                onTap: () {
                  getImage(true);
                  // await widget.hspOnchange(_url);
                },
              ),
              DoubleClick(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colours.color_181A23,
                  child: Center(
                      child: Text("从手机相册选择",
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                ),
                onTap: () {
                  getImage(false);
                  // await widget.hspOnchange(_url);
                },
              ),
              Divider(
                height: 0.5,
                color: Colours.color_3E414B,
                indent: 12,
                endIndent: 12,
              ),
              DoubleClick(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.color_181A23,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  width: double.infinity,
                  height: 60,
                  child: Center(
                      child: Text("取消",
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // await widget.hspOnchange(_url);
                },
              ),
            ],
          )),
    );
  }

  ///记录每次选择的图片
  List<File> _images = [];

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    try {
      XFile? file = await ImagePicker().pickImage(
          source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);
      if (file == null) {
        return;
      } else {
        WFLogUtil.d(file);
        if (widget.isCrop) {
          File? cropFile = await ImageCropper().cropImage(
              sourcePath: file.path,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ]);
          widget.callBack.call(cropFile);
          setState(() {
            _images.add(cropFile!);
          });
        } else {
          widget.callBack.call(file);
          setState(() {
            _images.add(File(file.path));
          });
        }
      }
    } catch (e) {
      WFLogUtil.d("模拟器不支持相机！");
    }
  }
}
