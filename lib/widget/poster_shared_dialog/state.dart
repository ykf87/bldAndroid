class PosterSharedDialogState {
  final List<Item> list = [
    Item('assets/svg/ic_wechat.svg', '微信好友'),
    Item('assets/svg/ic_moments.svg', '朋友圈'),
    Item('assets/svg/ic_save.svg', '保存本地'),
  ];


  List<String> listResume = [
  ];

  PosterSharedDialogState() {
    ///Initialize variables
  }
}
class Item {
  String url;
  String name;

  Item(this.url, this.name);
}