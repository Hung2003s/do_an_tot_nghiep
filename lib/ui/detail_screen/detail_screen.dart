// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cache_image/cache_image.dart';
import '../../const/app_scaffold.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/constant.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../home/app_router.dart';
import '../detail_item/item_list.dart';
import 'detail_more.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.arguments,
    required this.argumentsList,
    required this.title,
    required this.fromRoute,
  });

  final title;
  final arguments;
  final argumentsList;
  final FromRoute? fromRoute;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ScrollController _scrollController = ScrollController();

  dynamic data;
  String label = '';

  @override
  void initState() {
    data = widget.arguments;
    label = widget.title;
    super.initState();
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
                SliverToBoxAdapter(child: _buildDescreption()),
                SliverToBoxAdapter(child: _buildListRelated()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 325 + MediaQuery.of(context).padding.top;
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        child: _buildHeaderBody(),
        maxHeight: headerHeight,
        minHeight: headerHeight,
      ),
    );
  }

  Widget _buildHeaderBody() {
    return Stack(
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: OneColors.brandVNPT,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (widget.fromRoute == FromRoute.listItem) {
                    Get.until(
                      (Route<dynamic> route) =>
                          route.settings.name ==
                          AppRoute.anatomyDetailScreen.name,
                    );
                  } else {
                    Get.until(
                      (Route<dynamic> route) =>
                          route.settings.name == AppRoute.homeTab.name,
                    );
                  }
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: OneColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data['name']}',
                    style: OneTheme.of(
                      context,
                    ).title2.copyWith(fontSize: 18, color: OneColors.white),
                  ),
                  Text(
                    label,
                    style: OneTheme.of(
                      context,
                    ).title2.copyWith(fontSize: 14, color: OneColors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: OneColors.white,
              boxShadow: const [
                BoxShadow(
                  color: OneColors.grey,
                  offset: Offset(0, 5),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Hero(
              tag: 'image',
              child: Center(
                child: CachedImage(
                  imageUrl: data['imageUrl'],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 275,
          left: 120,
          right: 120,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: OneColors.brandVNPT,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // do something
                      return Container();
                      //ShowImage3DScreen(image3d: _getImage3D());
                    },
                  ),
                );
              },
              child: Center(
                child: Text(
                  'Hiển thị 3D',
                  style: OneTheme.of(context).title2.copyWith(
                    color: OneColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescreption() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giới thiệu',
                style: OneTheme.of(
                  context,
                ).title2.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // do something
                        return DetailMoreScreen(arguments: data);
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Chi tiết giải phẫu',
                      style: OneTheme.of(context).title2.copyWith(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 4, 0, 255),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color.fromARGB(255, 4, 0, 255),
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            '${data['descreption']}',
            textAlign: TextAlign.justify,
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 14, color: OneColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildListRelated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Liên quan',
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 26,
          ),
          itemCount: widget.argumentsList.length,
          itemBuilder: (context, index) {
            return data['name'] != widget.argumentsList[index]['name']
                ? ItemListAnotomy(
                  arguments: data,
                  argumentsList: widget.argumentsList,
                  name: widget.argumentsList[index]['name'],
                  imageUrl: widget.argumentsList[index]['imageUrl'],
                  onTap: () {
                    setState(() {
                      data = widget.argumentsList[index];
                      label = _title(widget.argumentsList[index]['id']);
                    });
                  },
                )
                : Container();
          },
        ),
      ],
    );
  }

  String _title(String id) {
    switch (id) {
      case '1':
        return 'Đầu';
      case '2':
        return 'Thân';
      case '3':
        return 'Chi trên';
      case '4':
        return 'Chi dưới';
    }
    return '';
  }

  String _getImage3D() {
    switch (data['name']) {
      case 'Hộp sọ':
        return 'assets/glb/so_nao.glb';
      case 'Bàn chân':
        return 'assets/glb/ban_chan.glb';
      case 'Xương bàn tay':
        return 'assets/glb/ban_tay.glb';
      case 'Cơ chân':
        return 'assets/glb/chan_co.glb';
      case 'Xương sống':
        return 'assets/glb/cot_song_0logo.glb';
      case 'Xương hàm':
        return 'assets/glb/ham_rang.glb';
      case 'Hệ tiêu hoá':
        return 'assets/glb/he_tieu_hoa.glb';
      case 'Mắt':
        return 'assets/glb/mat.glb';
      case 'Ống dẫn khí':
        return 'assets/glb/ong_dan_khi.glb';
      case 'Phổi':
        return 'assets/glb/phoi.glb';
      case 'Tai':
        return 'assets/glb/tai.glb';
      case 'Cơ cánh tay':
        return 'assets/glb/tay_co.glb';
      case 'Hệ tiêu hoá':
        return 'assets/glb/he_tieu_hoa.glb';
      case 'Xương chi trên':
        return 'assets/glb/tay_xuong.glb';
      case 'Tim':
        return 'assets/glb/tim.glb';
      case 'Xương chậu':
        return 'assets/glb/xuong_chau.glb';
      case 'Xương chi dưới':
        return 'assets/glb/xuong_chi_duoi.glb';
      case 'Xương sườn':
        return 'assets/glb/xuong_suon.glb';
      case 'Não':
        return 'assets/glb/nao_2.glb';
      default:
        return 'assets/glb/so_nao.glb';
    }
  }
}
