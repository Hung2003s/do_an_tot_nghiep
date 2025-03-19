import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cache_image/cache_image.dart';
import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/sliver_app_bar_delegate.dart';

class DetailMoreScreen extends StatefulWidget {
  const DetailMoreScreen({super.key, this.arguments});

  final arguments;

  @override
  State<DetailMoreScreen> createState() => _DetailMoreScreenState();
}

class _DetailMoreScreenState extends State<DetailMoreScreen> {
  final ScrollController _scrollController = ScrollController();

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: OneColors.white,
          surfaceTintColor: OneColors.white,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: InteractiveViewer(
              panEnabled: false,
              // Set it to false
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Center(
                child: CachedImage(
                  imageUrl: widget.arguments['detail'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
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
                SliverToBoxAdapter(child: _buildBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 80 + MediaQuery.of(context).padding.top;
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
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: OneColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back, color: OneColors.black, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Chi tiết giải phẫu',
            style: OneTheme.of(
              context,
            ).title1.copyWith(fontSize: 18, color: OneColors.brandVNPT),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: OneColors.grey.withOpacity(0.3),
            ),
            child: Center(
              child: CachedImage(
                imageUrl: widget.arguments['imageUrl'],
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${widget.arguments['name']}',
            style: OneTheme.of(context).title1.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              _showImageDialog();
            },
            child: Center(
              child: CachedImage(imageUrl: widget.arguments['detail']),
            ),
          ),
          const SizedBox(height: 10),
          Center(child: CachedImage(imageUrl: widget.arguments['imageDetail'])),
        ],
      ),
    );
  }
}
