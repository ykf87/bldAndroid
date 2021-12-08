import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/widget/web_view_page.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/page/mime/page/config/config_view.dart';
import 'package:SDZ/page/mime/page/my_focus_talent/view.dart';
import 'package:SDZ/page/mime/page/pr_visiting_card/view.dart';
import 'package:SDZ/page/mime/page/publish_announcement/view.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/common_widgets.dart';
import 'package:SDZ/widget/double_click.dart';

import '../setting_page.dart';
import 'logic.dart';
import 'state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:SDZ/page/mime/page/base_info_page.dart';
import 'package:SDZ/page/mime/page/my_browse_records/view.dart';
import 'package:SDZ/page/mime/page/my_collect/view.dart';
import 'package:SDZ/page/mime/page/setting_page.dart';
import 'package:SDZ/page/mime/widget/count_title_widget.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/login_util.dart';

class TabMyPage extends StatefulWidget {
  @override
  _TabMyPageState createState() => _TabMyPageState();
}

class _TabMyPageState extends State<TabMyPage> {
  final Tab_myLogic logic = Get.put(Tab_myLogic());
  final Tab_myState state = Get.find<Tab_myLogic>().state;
  int clickCount = 0;
  int lastTime = 0;

  @override
  void initState() {
    super.initState();
    logic.getData();
    logic.initEvent();
    state.isLogin = SPUtils.isLogined();
  }

  @override
  void dispose() {
    super.dispose();
    state.loginEventBus?.cancel();
    state.userCenterEventBus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Tab_myLogic>(
      init: Tab_myLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: new SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child:Center(
              child: DoubleClick(
                  onTap: (){
                    Get.to(BaseInfoPage());
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colours.red,
                  )),
            ),
          )),
        );
      },
    );
  }

}
