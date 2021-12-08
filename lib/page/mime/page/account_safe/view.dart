import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/dialog/cancellation_tips_dialog.dart';
import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/page/mime/page/cancellation_phone/view.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/sputils.dart';

import 'logic.dart';
import 'state.dart';

class AccountSafePage extends StatelessWidget {
  final Account_safe_pageLogic logic = Get.put(Account_safe_pageLogic());
  final Account_safe_pageState state = Get.find<Account_safe_pageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('账号安全',
            style: TextStyle(color: Colours.bg_ffffff, fontSize: 20)),
        leading: IconButton(
          color: Colors.white,
          tooltip: null,
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.only(left: 8),
          //   width: double.infinity,
          //   color: Colors.white,
          //   child: Text('手机号',
          //       style: TextStyle(fontSize: 16, color: Colours.text_131313)),
          // ),
          // LineTextWidget(
          //     leftText: SPUtils.getUserAccount() == null
          //         ? ''
          //         : SPUtils.getUserAccount()
          //             .replaceFirst(new RegExp(r'\d{4}'), '****', 3),
          //     rightText: '更换',
          //     onPressed: () {
          //       Get.to(BindPhonePage());
          //     }),
          LineTextWidget(leftText: '账号注销',
              rightText: SPUtils.getUserAccount().replaceFirst(new RegExp(r'\d{4}'), '****', 3),
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (_) => CancellationTipsDialog(onPressed: () {
                      Get.to(CancellationPhonePage());
                    },content: '1.注销后，该账号的所有信息，包括名片、关注粉丝关系、私聊关系以及聊天记录等，均将清除且无法恢复，请谨慎操作。\n2.注销成功后，该手机号可以重新注册，生成的账号为一个全新的账号。'));
              },
              bgColor: Colours.dark_bg_color),
        ],
      ),
    );
  }
}
