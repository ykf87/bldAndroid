import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_dialog.dart';
import 'package:SDZ/constant/wf_constant.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/search/platform_entity.dart';
import 'package:SDZ/entity/search/search_options_entity.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/text_image_button.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/skill_entity.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/6 16:21
/// @Description: 首页筛选

class IndexSearchDialog extends BaseDialog {
  final String? searchKey;

  final Function? onSearch;

  final SearchOptionsEntity? optionsEntity;

  IndexSearchDialog(
      {this.searchKey = 'IndexSearchDialog',
      this.optionsEntity,
      this.onSearch});

  @override
  BaseDialogState<BaseDialog> getState() => _IndexSearchState();
}

class _IndexSearchState extends BaseDialogState<IndexSearchDialog> {
  FocusNode _minFocusNode = FocusNode();
  FocusNode _maxFocusNode = FocusNode();
  TextEditingController? _minTextEditingController;
  TextEditingController? _maxTextEditingController;

  List<PlatformEntity> platformList = Utils.getPlatformEntityList();

  /// 达人领域
  List<SkillEntity> talentFieldList = [];

  Map<String, dynamic>? _searchOptionsMap;

  @override
  Color color() => Colors.transparent;

  @override
  double radius() => 0;

  @override
  double maxWidth() => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    setOptions();
    ApiClient.instance.get(ApiUrl.tag_kol_skills, onSuccess: (data) {
      BaseEntity<List<SkillEntity>> entity = BaseEntity.fromJson(data!);
      if (entity.data!.length != 0) {
        talentFieldList = entity.data!;
        if (_searchOptionsMap?['skillTagList'] != null) {
          List list = _searchOptionsMap!['skillTagList'];
          list.forEach((element) {
            talentFieldList.forEach((entity) {
              if (entity.skillLabel == element) {
                entity.isSelect = true;
              }
            });
          });
        }
        setState(() {});
      }
    });
  }

  void setOptions() {
    if (widget.optionsEntity != null) {
      _searchOptionsMap = {
        'minFansCount': widget.optionsEntity?.minFans ?? '',
        'maxFansCount': widget.optionsEntity?.maxFans ?? '',
        'cardTypes': widget.optionsEntity?.platformList ?? [],
        'skillTagList': widget.optionsEntity?.skillTagList ?? [],
      };
    } else {
      if (widget.searchKey! == 'IndexSearchDialog') {
        if (WFConstant.SEARCH_OPTIONS.isNotEmpty) {
          _searchOptionsMap = json.decode(WFConstant.SEARCH_OPTIONS);
        }
      } else {
        if (Utils.getSearchOptions(widget.searchKey!).isNotEmpty) {
          _searchOptionsMap =
              json.decode(Utils.getSearchOptions(widget.searchKey!));
        }
      }
    }

    _minTextEditingController =
        TextEditingController(text: _searchOptionsMap?['minFansCount'] ?? '');
    _maxTextEditingController =
        TextEditingController(text: _searchOptionsMap?['maxFansCount'] ?? '');
    if (_searchOptionsMap?['cardTypes'] != null) {
      List list = _searchOptionsMap!['cardTypes'];
      list.forEach((element) {
        platformList.forEach((entity) {
          if (entity.type == element) {
            entity.isSelect = true;
          }
        });
      });
      setState(() {});
    }
  }

  @override
  void dispose() {
    _minTextEditingController?.dispose();
    _maxTextEditingController?.dispose();
    _maxFocusNode.dispose();
    _minFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget initBuild(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colours.color_10121A,
              padding: const EdgeInsets.only(
                  left: 12, right: 0, bottom: 20, top: kToolbarHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('筛选',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: () {
                            saveSearchOptions();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 19),
                            child: Text('平台筛选',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12, top: 12),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 12.0,
                                          childAspectRatio: 3.0,
                                          mainAxisSpacing: 12.0),
                                  itemCount: platformList.length,
                                  itemBuilder: (context, index) {
                                    return DoubleClick(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _minFocusNode.unfocus();
                                        _maxFocusNode.unfocus();
                                        platformList[index].isSelect =
                                            !platformList[index].isSelect;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: platformList[index].isSelect
                                                ? Colors.white
                                                : Colours.color_181A23,
                                            borderRadius:
                                                BorderRadius.circular((8))),
                                        child: Center(
                                          child: TextImageButton(
                                            iconType: 3,
                                            svgPath:
                                                platformList[index].svgPath!,
                                            size: const Size(20, 20),
                                            text: platformList[index].title!,
                                            textStyle: TextStyle(
                                                color:
                                                    platformList[index].isSelect
                                                        ? Colours.text_121212
                                                        : Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            interceptGesture: true,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Text(
                              '平台粉丝',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12, right: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colours.color_181A23,
                                        borderRadius:
                                            BorderRadius.circular((8))),
                                    child: TextField(
                                      controller: _minTextEditingController,
                                      focusNode: _minFocusNode,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: '最低粉丝量',
                                        hintStyle: TextStyle(
                                            color: Colours.color_595D6D,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(8),
                                        CustomTextInputFormatter(
                                          filterPattern: RegExp("[0-9]"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text('至',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colours.color_181A23,
                                        borderRadius:
                                            BorderRadius.circular((8))),
                                    child: TextField(
                                      controller: _maxTextEditingController,
                                      focusNode: _maxFocusNode,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: '最高粉丝量',
                                        hintStyle: TextStyle(
                                            color: Colours.color_595D6D,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(8),
                                        CustomTextInputFormatter(
                                          filterPattern: RegExp("[0-9]"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          talentFieldList.length == 0
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 40),
                                      child: Text(
                                        '达人领域',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    MediaQuery.removePadding(
                                        removeTop: true,
                                        removeBottom: true,
                                        context: context,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 12, top: 12),
                                          child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 12.0,
                                                      childAspectRatio: 3.0,
                                                      mainAxisSpacing: 12.0),
                                              itemCount: talentFieldList.length,
                                              itemBuilder: (context, index) {
                                                return DoubleClick(
                                                  onTap: () {
                                                    _minFocusNode.unfocus();
                                                    _maxFocusNode.unfocus();
                                                    talentFieldList[index]
                                                            .isSelect =
                                                        !talentFieldList[index]
                                                            .isSelect;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: talentFieldList[
                                                                    index]
                                                                .isSelect
                                                            ? Colors.white
                                                            : Colours
                                                                .color_181A23,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular((8))),
                                                    child: Center(
                                                      child: Text(
                                                        talentFieldList[index]
                                                            .skillLabel!,
                                                        style: TextStyle(
                                                            color: talentFieldList[
                                                                        index]
                                                                    .isSelect
                                                                ? Colours
                                                                    .text_121212
                                                                : Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ))
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32, right: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                reset();
                              },
                              child: Text(
                                '重置',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colours.color_1F212B),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: Colors.white, width: 0.5))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 44,
                            margin: const EdgeInsets.only(left: 12),
                            child: ElevatedButton(
                              onPressed: () {
                                doSearch();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colours.color_FF193C),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                              child: Text(
                                '确定',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: DoubleClick(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                saveSearchOptions();
                Navigator.of(context).pop();
              },
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }

  /// 重置
  reset() {
    unFocus();
    _maxTextEditingController?.clear();
    _minTextEditingController?.clear();
    platformList.forEach((element) {
      element.isSelect = false;
    });
    talentFieldList.forEach((element) {
      element.isSelect = false;
    });
    setState(() {});
  }

  /// 取消焦点
  unFocus() {
    _maxFocusNode.unfocus();
    _minFocusNode.unfocus();
  }

  /// 搜索
  doSearch() {
    List cardTypes = [];
    platformList.forEach((element) {
      if (element.isSelect) {
        cardTypes.add(element.type);
      }
    });
    List skillTagList = [];
    talentFieldList.forEach((element) {
      if (element.isSelect) {
        skillTagList.add(element.skillLabel!);
      }
    });
    saveSearchOptions();
    if (_minTextEditingController!.text.isNotEmpty &&
        _maxTextEditingController!.text.isNotEmpty &&
        int.parse(_maxTextEditingController!.text) <=
            int.parse(_minTextEditingController!.text)) {
      ToastUtils.toast('最高粉丝必须大于最低粉丝数');
      return;
    }
    Map<String, dynamic> map = Map();
    if (widget.searchKey! != 'IndexSearchDialog') {
      map['pageNum'] = 1;
    }
    if (cardTypes.length > 0) {
      map['cardTypes'] = cardTypes;
    }
    if (skillTagList.length > 0) {
      map['skillTagList'] = skillTagList;
    }
    if (_minTextEditingController!.text.isNotEmpty) {
      map['minFansCount'] = _minTextEditingController!.text;
    }
    if (_maxTextEditingController!.text.isNotEmpty) {
      map['maxFansCount'] = _maxTextEditingController!.text;
    }
    widget.onSearch?.call(map);
    unFocus();
    Navigator.of(context).pop();
  }

  /// 保存搜索条件
  saveSearchOptions() {
    List cardTypes = [];
    platformList.forEach((element) {
      if (element.isSelect) {
        cardTypes.add(element.type!);
      }
    });
    List skillTagList = [];
    talentFieldList.forEach((element) {
      if (element.isSelect) {
        skillTagList.add(element.skillLabel!);
      }
    });
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['minFansCount'] = _minTextEditingController!.text;
    data['maxFansCount'] = _maxTextEditingController!.text;
    data['cardTypes'] = cardTypes;
    data['skillTagList'] = skillTagList;
    if (widget.searchKey! == 'IndexSearchDialog') {
      WFConstant.SEARCH_OPTIONS = json.encode(data);
    } else {
      Utils.saveSearchOptions(widget.searchKey!, json.encode(data));
    }
  }
}
