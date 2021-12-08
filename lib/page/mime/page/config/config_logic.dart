import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SDZ/utils/sputils.dart';

import 'config_state.dart';

class ConfigLogic extends GetxController {
  final ConfigState state = ConfigState();

  void getProxySwitch() {
    state.proxySwitch = SPUtils.getProxySwitch();
  }

  void saveProxySwitchToLocal(bool proxySwitch) {
    SPUtils.setProxySwitch(proxySwitch);
  }

  void saveProxyIPToLocal(String proxyIp) {
    SPUtils.setProxyIp(proxyIp);
  }

  void setProxySwitchToMemory(bool proxySwitch) {
    state.proxySwitch = proxySwitch;
    update();
  }
}
