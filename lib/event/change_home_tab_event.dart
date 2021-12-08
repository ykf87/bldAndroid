import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ChangeHomeTabEvent {
  int curTabPosition = 0;

  ChangeHomeTabEvent(int pos) {
    this.curTabPosition = pos;
  }
}
