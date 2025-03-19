
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../const/ar_image.dart';

import '../ui/homepage/home_page.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  var _indexPages = 0;

  final pageOtions = [
    const HomePageScreen(),
    //const ScanScreen(),
    //const EvolutionScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOtions[_indexPages],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(),
        child: CurvedNavigationBar(
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: const Color(0xffD4EDF9),
          color: const Color(0xffA084DC),
          animationCurve: Curves.easeOutSine, //kiểu của tabbar chuyển tabs
          items: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Image.asset(ArImages.main_menu),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Image.asset(ArImages.ar_menu),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Image.asset(ArImages.history),
            ),
          ],
          onTap: ((int index) {
            setState(() {
              _indexPages = index;
            });
          }),
        ),
      ),
    );
  }
}