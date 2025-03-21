import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../const/app_scaffold.dart';
import '../const/ar_color.dart';
import '../const/ar_image.dart';
import '../const/ar_theme.dart';
import '../home/app_router.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          ImageSlideshow(
            disableUserScrolling: true,
            height: MediaQuery.of(context).size.height * 0.7,
            initialPage: 0,

            // the color to paint indicator
            indicatorColor: OneColors.brandVNPT,

            // the color to paint behind the indicator
            indicatorBackgroundColor: OneColors.grey,
            onPageChanged: (value) {
              if (value == 2) {
                Future.delayed(const Duration(seconds: 2), (() {
                  setState(() {
                    Get.toNamed(AppRoute.homeTab.name);
                  });
                }));
              }
            },

            autoPlayInterval: 1500,
            isLoop: false,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: Text(
                      'Hỗ trợ trực quan việc học giải phẫu',
                      style: OneTheme.of(context).body1.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      ArImages.intro_1,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: Text(
                      'Hiển thị mô hình 3D với các tương tác trực quan',
                      style: OneTheme.of(context).body1.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    ArImages.intro_2,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Hỗ trợ hiển thị mô hình 3D trên mặt phẳng',
                      style: OneTheme.of(context).body1.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Image.asset(
                    ArImages.intro_3,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          Text(
            'Xin chào',
            style: OneTheme.of(context).body1.copyWith(fontSize: 28),
          ),
          Lottie.asset(
            "assets/animation/loading.json",
            width: 110,
            height: 110,
            repeat: true,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
