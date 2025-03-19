
import 'package:flutter/material.dart';

import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/loading.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../fire_base/fire_base.dart';
import 'item_detail.dart';

class AnotomyDetailScreen extends StatefulWidget {
  const AnotomyDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<AnotomyDetailScreen> createState() => _AnotomyDetailScreenState();
}

class _AnotomyDetailScreenState extends State<AnotomyDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _dataList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _layDanhSachBoPhan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        color: OneColors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Scrollbar(
                child: CustomScrollView(controller: _scrollController, physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()), slivers: <Widget>[
                  _buildHeader(),
                  _buildTitle('Hệ thống xương'),
                  _buildBodyFirstId('1'),
                  _buildTitle(_titleSecond()),
                  _buildBodyFirstId('2'),
                  _buildTitle(_titleThird()),
                  _buildBodyFirstId('3'),
                  _buildTitle(_titleFour()),
                  _buildBodyFirstId('4'),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.arrow_back,
                    color: OneColors.brandVNPT,
                    size: 24,
                  ),
                ),
              ),
              Text(
                _title(),
                style: OneTheme.of(context).title2.copyWith(fontSize: 18, color: OneColors.brandVNPT),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        child: _buildHeaderBody(),
        maxHeight: 70,
        minHeight: 0,
      ),
    );
  }

  SliverToBoxAdapter _buildBodyFirstId(String? id) {
    final List<Map<String, dynamic>> filteredItems = _dataList.where((item) => item['id'] == id).toList();
    return SliverToBoxAdapter(
      child: GridView.count(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(
          filteredItems.length,
              (index) {
            return ItemDetailAnotomy(
              title: _title(),
              arguments: filteredItems[index],
              argumentsList: _dataList,
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTitle(String? title) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Text(
          title ?? '',
          style: OneTheme.of(context).title2.copyWith(fontSize: 14, color: OneColors.brandVNPT),
        ),
      ),
    );
  }

  String _title() {
    switch (widget.id) {
      case 1:
        return 'Đầu';
      case 2:
        return 'Thân';
      case 3:
        return 'Chi trên';
      case 4:
        return 'Chi dưới';
    }
    return '';
  }

  void _layDanhSachBoPhan() {
    switch (widget.id) {
      case 1:
        try {
          Loading.show();
          layDanhSachDau().then((data) {
            setState(() {
              _dataList = data;
              if (_dataList.isNotEmpty) {
                Loading.dismiss();
              }
            });
          });
        } finally {}

      case 2:
        try {
          Loading.show();
          layDanhSachThan().then((data) {
            setState(() {
              _dataList = data;
              if (_dataList.isNotEmpty) {
                Loading.dismiss();
              }
            });
          });
        } finally {}
      case 3:
        try {
          Loading.show();
          layDanhSachChiTren().then((data) {
            setState(() {
              _dataList = data;
              if (_dataList.isNotEmpty) {
                Loading.dismiss();
              }
            });
          });
        } finally {}
      case 4:
        try {
          Loading.show();
          layDanhSachChiDuoi().then((data) {
            setState(() {
              _dataList = data;
              if (_dataList.isNotEmpty) {
                Loading.dismiss();
              }
            });
          });
        } finally {}
    }
  }

  String _titleSecond() {
    switch (widget.id) {
      case 1:
      case 2:
        return 'Hệ thống thần kinh';
      case 3:
      case 4:
        return '';
    }
    return '';
  }

  String _titleThird() {
    switch (widget.id) {
      case 1:
        return 'Hệ thống giác quan';
      case 2:
        return 'Hệ thống hô hấp';
      case 3:
      case 4:
        return '';
    }
    return '';
  }

  String _titleFour() {
    switch (widget.id) {
      case 1:
        return '';
      case 2:
        return 'Hệ thông tiêu hóa';
      case 3:
      case 4:
        return '';
    }
    return '';
  }
}