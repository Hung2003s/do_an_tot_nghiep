import 'package:flutter/material.dart';

import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_image.dart';
import '../../const/ar_theme.dart';
import '../../const/loading.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../fire_base/fire_base.dart';
import 'evolution_item.dart';

class EvolutionScreen extends StatefulWidget {
  const EvolutionScreen({super.key});

  @override
  State<EvolutionScreen> createState() => _EvolutionScreenState();
}

class _EvolutionScreenState extends State<EvolutionScreen> {
  List<Map<String, dynamic>> _dataList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        Loading.show();
        layDanhSachTienHoa().then((data) {
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
            child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: <Widget>[
                  _buildHeader(),
                  SliverToBoxAdapter(child: _buildListEvolution()),
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
      padding: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: OneColors.brandVNPT,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Column(
        children: [
          Text(
            'Lịch sử giải phẫu',
            style: OneTheme.of(context)
                .title1
                .copyWith(fontSize: 18, color: OneColors.white),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ArImages.evulotion,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListEvolution() {
    return Column(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding:
          const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 26),
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            return ItemEvolution(
              descreption: _dataList[index]['descreption'],
              imageUrl: _dataList[index]['imageUrl'],
              title: _dataList[index]['title'],
              title1: _dataList[index]['title1'],
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
