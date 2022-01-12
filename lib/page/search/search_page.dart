
import 'package:SDZ/base/get/get_common_view.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/page/search/search_controller.dart';
import 'package:SDZ/page/search/widget/search_result_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/style.dart';
import 'package:SDZ/widget/appbar_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widget/search_history_widget.dart';
import 'widget/search_top_widget.dart';

/// @class : SearchPage
/// @date : 2021/9/3
/// @name : jhf
/// @description :搜索页面 View层

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ///输入框文本控制器
  TextEditingController textController = TextEditingController(text: '');
  bool isShowContent= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Box.vBox15,
            SAppBarSearch(eve: 0,onSearch: (content){
              setState(() {
                isShowContent = true;
              });
            },onClear: (){
              setState(() {
                isShowContent = false;
              });
            },),
            Box.vBox15,
            isShowContent? Expanded(child: Container(
                margin: EdgeInsets.only(top: 196),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/img_collection_empty.svg',height: 120,width: 120,),
                    SizedBox(height: 20,),
                    Text('暂无数据~',style: TextStyle(color: Colours.text_main,fontSize: 14),),
                    SizedBox(height: 28),
                  ],
                ))):SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

