import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ShowSharedDialogEvent {
  static int TALENT_HOME = 1;
  static int TALENT_CARD = 2;
  int page = 1;
  ShowSharedDialogEvent(int page) {
    this.page = page;
  }
}
