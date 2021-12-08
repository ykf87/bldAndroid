class IndexState {
  int? hasMessage;
  int? hasNotice; //0无 1有
  int curTabIndex = 0; //用于标记当前tab
  bool showTabLogin = false;

  IndexState() {
    ///Initialize variables
  }
}
