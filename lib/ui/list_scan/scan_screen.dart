import 'package:flutter/material.dart';

import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/loading.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../fire_base/fire_base.dart';
import 'item_scan.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<Map<String, dynamic>> _dataList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Loading.show();
      try {
        layDanhSachScanAr().then((data) {
          setState(() {
            _dataList = data;
            if (_dataList.isNotEmpty) {
              Loading.dismiss();
            }
          });
        });
      } finally {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isHideStatus: false,
      backgroundColor: OneColors.background,
      statusBarIconStyle: StatusBarIconStyle.light,
      body: Stack(
        children: [
          Scrollbar(
            child: CustomScrollView(controller: _scrollController, physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()), slivers: <Widget>[
              _buildHeader(),
              SliverToBoxAdapter(child: _buildListScan()),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 240 + MediaQuery.of(context).padding.top;
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        child: _buildHead(),
        maxHeight: headerHeight,
        minHeight: headerHeight,
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
          color: OneColors.brandVNPT,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'AR',
            style: OneTheme.of(context).title1.copyWith(fontSize: 18, color: OneColors.white),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/image/ex1.png',
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(height: 10),
                              Text(
                                'Chọn bộ phận bạn muốn quét',
                                style: OneTheme.of(context).title1.copyWith(fontSize: 10),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 40,
                            color: OneColors.black,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/image/ex2.png',
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(height: 20),
                              Text(
                                'Chọn mặt phẳng để hiển thị',
                                style: OneTheme.of(context).title1.copyWith(fontSize: 10),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 40,
                            color: OneColors.black,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/image/ex3.png',
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(height: 20),
                              Text(
                                'Giữ cố định máy để hiện ảnh 3D',
                                style: OneTheme.of(context).title1.copyWith(fontSize: 10),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListScan() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          'Danh sách bộ phận có hỗ trợ quét',
          style: OneTheme.of(context).title1.copyWith(fontSize: 18),
        ),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 26),
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            return ItemScanAr(
              index: index,
              title: _dataList[index]['title'],
              descreption: _dataList[index]['descreption'],
              imageUrl: _dataList[index]['imageUrl'],
              image3d: _dataList[index]['image3d'],
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}