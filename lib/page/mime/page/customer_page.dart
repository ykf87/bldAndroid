import 'dart:io';

import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/Constants.dart';
import 'package:SDZ/page/login/cancle.dart';
import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/event.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/mime/page/about_page.dart';
import 'package:SDZ/page/mime/page/account_safe/view.dart';
import 'package:SDZ/page/mime/page/feed_back/view.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/clear_cache_utils.dart';
import 'package:SDZ/utils/jpush_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/widget/double_click.dart';

///联系客服
class CustomerPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _CustomerPageState();
}

class _CustomerPageState extends  BaseStatefulState<CustomerPage> with WidgetsBindingObserver {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    print("TTTTTT====${ SPUtils.getServiceImg()}");
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  String navigatorTitle() {
    return '联系客服';
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(12.0)),
          image: new DecorationImage(
            image: SPUtils.getServiceImg().isNotEmpty
                ? ImageUtils.getImageProvider(SPUtils.getServiceImg())
                : new ExactAssetImage('assets/images/bg_login.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),

    );
  }


}
