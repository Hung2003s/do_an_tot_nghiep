import 'package:flutter/material.dart';

import '../../cache_image/cache_image.dart';
import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/sliver_app_bar_delegate.dart';

class DetailScreenTips extends StatefulWidget {
  const DetailScreenTips({super.key, this.arguments});

  final arguments;

  @override
  State<DetailScreenTips> createState() => _DetailScreenTipsState();
}

class _DetailScreenTipsState extends State<DetailScreenTips> {
  final ScrollController _scrollController = ScrollController();

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
                SliverToBoxAdapter(child: _buildImage()),
                SliverToBoxAdapter(child: _buildBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 60 + MediaQuery.of(context).padding.top;
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
        color: OneColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back, color: OneColors.black, size: 24),
              Text(
                widget.arguments['title'],
                style: OneTheme.of(context).title1.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CachedImage(
        imageUrl: widget.arguments['imageUrl'],
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        widget.arguments['full'],
        style: OneTheme.of(context).title2.copyWith(fontSize: 18),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
