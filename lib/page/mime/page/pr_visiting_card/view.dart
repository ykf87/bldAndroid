import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/my_scroll_view.dart';

import 'logic.dart';
import 'state.dart';

class PrVisitingCardPage extends StatefulWidget {
  @override
  _PrVisitingCardPageState createState() => _PrVisitingCardPageState();
}

class _PrVisitingCardPageState extends State<PrVisitingCardPage> {
  final PrVisitingCardLogic logic = Get.put(PrVisitingCardLogic());
  final PrVisitingCardState state = Get.find<PrVisitingCardLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getSkillList();
    if (Get.arguments != null) {
      var map = Get.arguments;
      state.carID = map['cardId'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrVisitingCardLogic>(
      init: PrVisitingCardLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
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
            centerTitle: true,
            title: Text('PR名片',
                style: TextStyle(color: Colours.bg_ffffff, fontSize: 20)),
          ),
          body: GetBuilder<PrVisitingCardLogic>(
            init: PrVisitingCardLogic(),
            builder: (logic) {
              return MyScrollView(
                padding:
                    const EdgeInsets.symmetric( horizontal: 12),
                tapOutsideToDismiss: true,
                children: _buildBody(),
                bottomButton: bottomBtn(),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildBody() {
    return [
      (state.prCardInfoEntity?.status != 1 &&
              state.prCardInfoEntity?.status != 4)
          ? SizedBox.shrink()
          : FailResonWidget(),
      selectIdentity(),
      item('公司名称', '请输入公司名称', state.controllerCompany, 30,
          state.focusNodecompny),
      item('您的职位', '请输入您的职位', state.controllerJob, 10, state.focusNodeJob),
      selectSkill(),
      uploadCard(),
    ];
  }

  //未通过原因
  Widget FailResonWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colours.dark_bg_color2,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: 4),
              child: SvgPicture.asset(
                Utils.getSvgUrl('ic_warn.svg'),
                width: 16,
                height: 16,
              )),
          SizedBox(width: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('很抱歉，您的认证申请未审核通过，请修改后重新提交，原因:',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(
                height: 10,
              ),
              Text(logic.remark,
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ))
        ],
      ),
    );
  }

  //选择身份
  Widget selectIdentity() {
    return GetBuilder<PrVisitingCardLogic>(
      init: logic,
      builder: (logic) {
        return Column(
          children: [
            SizedBox(
              height: 26,
            ),
            Row(
              children: [
                Text('您的身份',
                    style: TextStyle(color: Colours.text_main, fontSize: 14)),
                SizedBox(width: 8),
                SvgPicture.asset(
                  Utils.getSvgUrl('ic_asterisk.svg'),
                  width: 8,
                  height: 8,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                DoubleClick(
                  onTap: () {
                    // 触摸收起键盘
                    // FocusScope.of(context).requestFocus(FocusNode());
                    logic.selectIdentity(state.brandValue);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: state.brandValue == state.selcetIdentityValue
                            ? Colours.bg_ffffff
                            : Colours.dark_bg_color2,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    height: 36,
                    width: 110,
                    child: Center(
                      child: Text(
                        '品牌方',
                        style: TextStyle(
                            color: state.brandValue == state.selcetIdentityValue
                                ? Colours.text_121212
                                : Colours.text_main,
                            fontSize: 14,fontWeight:  FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                DoubleClick(
                  onTap: () {
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                    logic.selectIdentity(state.prValue);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: state.prValue == state.selcetIdentityValue
                            ? Colours.bg_ffffff
                            : Colours.dark_bg_color2,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    height: 36,
                    width: 110,
                    child: Center(
                      child: Text(
                        'PR',
                        style: TextStyle(
                            color: state.prValue == state.selcetIdentityValue
                                ? Colours.text_121212
                                : Colours.text_main,
                            fontSize: 14,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  //选择擅长领域
  Widget selectSkill() {
    return GetBuilder<PrVisitingCardLogic>(
      init: logic,
      builder: (logic) {
        return Column(
          children: [
            SizedBox(
              height: 28,
            ),
            Row(
              children: [
                Text('擅长领域',
                    style: TextStyle(color: Colours.text_main, fontSize: 14)),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  Utils.getSvgUrl('ic_asterisk.svg'),
                  width: 8,
                  height: 8,
                ),
                Expanded(child: Container()),
                Text('至少选择一项',
                    style: TextStyle(color: Colours.text_717888, fontSize: 12)),
              ],
            ),
            SizedBox(height: 8),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.allSkillList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 12.0,
                  //横轴间距
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  return DoubleClick(
                    onTap: () {
                      // 触摸收起键盘
                      FocusScope.of(context).requestFocus(FocusNode());
                      logic.selectSkill(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: state.allSkillList[index].isSelect
                              ? Colours.bg_ffffff
                              : Colours.dark_bg_color2,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Center(
                        child: Text(
                          state.allSkillList[index].skillLabel,
                          style: TextStyle(
                              color: state.allSkillList[index].isSelect
                                  ? Colours.text_121212
                                  : Colours.text_main,
                              fontSize: 14,fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  //上传名片
  Widget uploadCard() {
    return GetBuilder<PrVisitingCardLogic>(
      init: logic,
      builder: (logic) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('上传名片',
                    style: TextStyle(color: Colours.text_main, fontSize: 14)),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  Utils.getSvgUrl('ic_asterisk.svg'),
                  width: 8,
                  height: 8,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            state.cardAvatar == null || state.cardAvatar?.length == 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DoubleClick(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colours.dark_bg_color2,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Colours.text_main,
                            ),
                          ),
                        ),
                        onTap: () {
                          // 触摸收起键盘
                          FocusScope.of(context).requestFocus(FocusNode());
                          logic.selectImgCard(context);
                        },
                      ),
                      SizedBox(width: 12),
                      Expanded(child: bottomTips())
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DoubleClick(
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  state.cardAvatar ?? '',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )

                                // Image.file(
                                //   File(state.imgCard!.path),
                                //   width: 100,
                                //   height: 100,
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Visibility(
                                  visible:
                                      (state.prCardInfoEntity?.status != 2 &&
                                          state.prCardInfoEntity?.status != 3),
                                  child: Container(
                                    height: 25,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colours.color_40000000,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '重新上传',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        onTap: () {
                          // 触摸收起键盘
                          FocusScope.of(context).requestFocus(FocusNode());
                          logic.selectImgCard(context);
                        },
                      ),
                      SizedBox(width: 12),
                      Expanded(child: bottomTips())
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  Widget bottomTips() {
    return Container(
      child: RichText(
        text: TextSpan(
            text: '上传名片，告诉我您的真实身份，让您的通告被更多人看到，',
            style:
                TextStyle(fontSize: 12, color: Colours.text_main, height: 1.5),
            children: [
              TextSpan(
                  text: ' 请不要冒用他人身份',
                  style: TextStyle(
                      fontSize: 12, color: Colours.text_main, height: 1.5))
            ]),
      ),
    );
  }

  Widget item(String title, String hintText, TextEditingController controller,
      int maxLength, FocusNode focusNode) {
    return DoubleClick(
      child: Column(
        children: [
          SizedBox(
            height: 28,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(color: Colours.text_main, fontSize: 14)),
                  SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(
                    Utils.getSvgUrl('ic_asterisk.svg'),
                    width: 8,
                    height: 8,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      cursorColor: Colours.text_main,
                      style: TextStyle(color: Colors.white, fontSize: 15.0,fontWeight:FontWeight.bold),
                      maxLength: maxLength,
                      maxLines: 1,
                      enabled: state.canEdit,
                      //审核不通过时才允许修改
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: title.contains('电话')
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "", // 此处控制最大字符是否显示
                        hintText: hintText,
                        hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
                height: 48.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: Colours.dark_bg_color2,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomBtn() {
    return Visibility(
      visible: state.prCardInfoEntity?.status != 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        child: DoubleClick(
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
            logic.commit();
          },
          child: Container(
              height: 45,
              padding: EdgeInsets.all(4),
              child: Center(
                child: Text(
                  '提交',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              decoration: BoxDecoration(
                color: Colours.color_main_red,
                borderRadius: BorderRadius.circular(8.0),
              )),
        ),
      ),
    );
  }
}
