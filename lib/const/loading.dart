
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

const String _kTitleText = 'Thông báo';
const String _kText = 'Vui lòng đợi ...';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    this.barrierColor = Colors.black54,
    this.title = _kTitleText,
    this.text = _kText,
    this.barrierDismissible = false,
  }) : super(key: key);

  final Color barrierColor;
  final String title;
  final String text;
  final bool barrierDismissible;

  static void show({
    bool barrierDismissible = false,
  }) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        Loading(
          barrierDismissible: barrierDismissible,
        ),
        barrierDismissible: barrierDismissible,
      );
    }
  }

  static void showWith({
    String title = _kTitleText,
    required String text,
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      Loading(
        title: title,
        text: text,
        barrierDismissible: barrierDismissible,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void dismiss() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildProgress(context);
  }

  Widget _buildProgress(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/loading.json',
                        width: 100,
                        height: 100,
                        animate: true,
                        repeat: true,
                        fit: BoxFit.contain,
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        child: Text(text, textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
