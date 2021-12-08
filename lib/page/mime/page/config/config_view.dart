import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/widget/common_widgets.dart';

import 'config_logic.dart';

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfigPageState();
  }
}

class ConfigPageState extends State<ConfigPage> {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  final logic = Get.put(ConfigLogic());
  final state = Get.find<ConfigLogic>().state;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    logic.getProxySwitch();
    _textEditingController!.text = SPUtils.getProxyIp();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    _focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("配置"),
        ),
        body: GetBuilder<ConfigLogic>(builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: sWidth(20)),
                child: Switch(
                  value: state.proxySwitch, //当前状态
                  onChanged: (value) {
                    logic.setProxySwitchToMemory(value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: sWidth(0), left: sWidth(20)),
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: '请输入本机IP',
                    hintStyle: TextStyle(
                        color: Colours.color_595D6D, fontSize: sFontSize(16)),
                    // border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: sWidth(100),
                height: sWidth(45),
                margin: EdgeInsets.only(top: sWidth(20), left: sWidth(20)),
                color: Colors.red,
                child: TextButton(
                  child: Text(
                    "确认",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    logic.saveProxySwitchToLocal(state.proxySwitch);
                    logic.saveProxyIPToLocal(
                        _textEditingController!.text.toString());
                    Get.back();
                    ToastUtils.toast("修改配置后，需要测底退出软件才生效");
                  },
                ),
              ),
            ],
          );
        }));
  }
}
