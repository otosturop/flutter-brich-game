import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class TimerController extends SuperController {
  var right = 3.obs;
  CountdownTimerController? controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void onInit() {
    super.onInit();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void decreaseRight() => right.value--;

  void onEnd() {
    if (right.value < 5) {
      right.value = right.value + 1;
      print('onEnd');
      this.endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
      this.controller =
          CountdownTimerController(endTime: endTime, onEnd: onEnd);
      controller?.start();
    }
  }

  Widget countDown() {
    return Center(
      child: CountdownTimer(
        controller: controller,
        endTime: endTime,
        onEnd: onEnd,
        widgetBuilder: (_, CurrentRemainingTime? time) {
          if (time == null) {
            return Text('Haklar Doldu!');
          }
          return Text(
              '${time.hours ?? "00"} : ${time.min ?? "00"} : ${time.sec}');
        },
      ),
    );
  }

  @override
  void onDetached() {
    print("detached");
  }

  @override
  void onInactive() {
    print("inactive");
  }

  @override
  void onPaused() {
    print("pause");
  }

  @override
  void onResumed() {
    print("resume");
  }
}
