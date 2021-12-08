import 'package:get/get.dart';

class GoodsDetailLogic extends GetxController {
  var _isAppBarExpanded = true;
  int _selectValue = 1;//选中的商品规格


  bool get isAppBarExpanded => _isAppBarExpanded;

  int get selectValue => _selectValue;

  void setSelect(int value){
    _selectValue = value;
    // update();
  }

  void setAppBarExpanded(bool isExpand){
    _isAppBarExpanded = isExpand;
    update();
    // Future.delayed(Duration(milliseconds: 1),(){update();});
  }
}
