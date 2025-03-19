import 'package:do_an_tot_nghiep/ui/tips/tips_item.dart';
import 'package:flutter/material.dart';

import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/loading.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../fire_base/fire_base.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key, required this.id});

  final int id;

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  List<Map<String, dynamic>> _dataListTips = [];
  List<Map<String, dynamic>> _dataListHandbook = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        Loading.show();
        layDanhSachTips().then((data) {
          setState(() {
            _dataListTips = data;
            if (_dataListTips.isNotEmpty) {
              Loading.dismiss();
            }
          });
        });
        layDanhSachHandbook().then((data) {
          setState(() {
            _dataListHandbook = data;
            if (_dataListHandbook.isNotEmpty) {
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
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                _buildHeader(),
                SliverToBoxAdapter(child: _buildBodyList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 90 + MediaQuery.of(context).padding.top;
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
    return Stack(
      children: [
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: color(),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: OneColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 55),
              if (widget.id == 1) ...[
                Text(
                  'Có thể bạn chưa biết',
                  style: OneTheme.of(
                    context,
                  ).title1.copyWith(fontSize: 20, color: OneColors.white),
                ),
              ] else if (widget.id == 2) ...[
                Text(
                  'Cẩm nang sức khỏe',
                  style: OneTheme.of(
                    context,
                  ).title1.copyWith(fontSize: 20, color: OneColors.white),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBodyList() {
    return Column(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 26,
          ),
          itemCount: _dataListTips.length,
          itemBuilder: (context, index) {
            return Item(arguments: data(index));
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Map<String, dynamic> data(int index) {
    switch (widget.id) {
      case 1:
        return _dataListTips[index];
      case 2:
        return _dataListHandbook[index];
      default:
        return _dataListTips[index];
    }
  }

  Color color() {
    switch (widget.id) {
      case 1:
        return OneColors.badge;
      case 2:
        return OneColors.yellow;
      default:
        return OneColors.badge;
    }
  }
}
