import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/entity/mime/pr_card_info_entity.dart';
import 'package:SDZ/entity/mime/pr_list_skill_entity.dart';

import 'entity/skill_entity.dart';

class PrVisitingCardState {
  TextEditingController controllerCompany = new TextEditingController();
  TextEditingController controllerJob = new TextEditingController();
  PrCardInfoEntity? prCardInfoEntity;
  FocusNode focusNodecompny = FocusNode();
  FocusNode focusNodeJob = FocusNode();

  int selcetIdentityValue = 0;//身份选中值
  int brandValue = 2;//品牌方
  int prValue = 1;//PR
  bool canEdit = true;//输入框是否可以编辑
  String? remark;
  int? carID = 0;//名片id

  List<PrListSkillEntity> allSkillList = [];//擅长领域
  List<int> selectList = [];//已选中的擅长领域

   XFile? imgCard;//上传的名片
   String? cardAvatar;//上传的名片

  PrVisitingCardState() {
    ///Initialize variables
  }
}
