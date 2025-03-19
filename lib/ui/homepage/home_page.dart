import 'package:do_an_tot_nghiep/const/app_scaffold.dart';
import 'package:do_an_tot_nghiep/const/ar_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../const/ar_image.dart';
import '../../const/ar_theme.dart';
import '../../const/sliver_app_bar_delegate.dart';
import '../../fire_base/fire_base.dart';
import '../../home/app_router.dart';
import 'item_search_home_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  late final TextEditingController _textController;

  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> dataListFilter = [];
  bool isListFilterEmty = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _layListDanhSachSearch();
  }

  String removeDiacritics(String str) {
    const withDiacritics =
        'áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ';
    const withoutDiacritics = 'aaaaaaaeeeeeeiiiiiooooooooouuuuuuyyyyyd';

    for (int i = 0; i < withDiacritics.length; i++) {
      str = str.replaceAll(withDiacritics[i], withoutDiacritics[i ~/ 5]);
    }

    return str;
  }

  bool fuzzySearch(String query, String name) {
    int queryIndex = 0;
    int nameIndex = 0;

    while (queryIndex < query.length && nameIndex < name.length) {
      if (query[queryIndex] == name[nameIndex]) {
        queryIndex++;
      }
      nameIndex++;
    }

    return queryIndex == query.length;
  }

  void _filterDataList(String query) {
    if (query.isEmpty) {
      setState(() {
        dataListFilter = dataList;
      });
    } else {
      final searchLower = removeDiacritics(query.toLowerCase());
      setState(() {
        dataListFilter =
            dataList.where((item) {
              final name = removeDiacritics(item['name']?.toLowerCase() ?? '');
              return fuzzySearch(searchLower, name);
            }).toList();
      });
    }
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
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                _buildHeader(),
                if (!isListFilterEmty) ...[
                  SliverToBoxAdapter(child: _buildCategory()),
                  SliverToBoxAdapter(child: _buildExtend())
                ] else ...[
                  SliverToBoxAdapter(child: _buildListSearch())
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final double headerHeight = 145 + MediaQuery.of(context).padding.top;
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
    return Container(
      decoration: const BoxDecoration(
        color: OneColors.brandVNPT,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SvgPicture.asset(
                //   ArImages.ic_menu,
                //   color: OneColors.white,
                // ),
                Text(
                  'Khám phá cơ thể con người',
                  style: OneTheme.of(
                    context,
                  ).title2.copyWith(fontSize: 20, color: OneColors.white),
                ),
              ],
            ),
          ),
          _buildSearch(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            top: 10.0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: OneColors.shadow.withOpacity(0.2),
                    blurRadius: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: OneColors.brandVNP,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionColor: OneColors.textGrey1,
                      ),
                    ),
                    child: TextField(
                      cursorColor: OneColors.white,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: OneColors.textGrey1,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.only(left: 20.0, right: 5.0),
                        fillColor: Colors.transparent,
                        filled: true,
                        counterText: "",
                      ),
                      style: OneTheme.of(
                        context,
                      ).textFieldText.copyWith(color: OneColors.white),
                      onTap: () {},
                      onEditingComplete: () {},
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _filterDataList(value);
                          isListFilterEmty = true;
                        } else {
                          setState(() {
                            isListFilterEmty = false;
                          });
                        }
                      },
                      maxLength: 20,
                      controller: _textController,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _filterDataList(_textController.text.trim());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: OneColors.white,
                    ),
                    child: const Icon(Icons.search, color: OneColors.brandVNP),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSearch() {
    return dataListFilter.isNotEmpty
        ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 26,
          ),
          itemCount: dataListFilter.length,
          itemBuilder: (context, index) {
            return ItemSearchHomePage(
              arguments: dataListFilter[index],
              argumentsList: dataList,
            );
          },
        )
        : Container(
          margin: const EdgeInsets.only(top: 80),
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 200,
            child: Image.asset(ArImages.no_search, fit: BoxFit.contain),
          ),
        );
  }

  Widget _buildCategory() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Danh mục',
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Chọn phần muốn khám phá',
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 14, color: OneColors.textGrey1),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItemBody(svgUrl: ArImages.ic_dau, title: 'Đầu', id: 1),
              _buildItemBody(svgUrl: ArImages.ic_than, title: 'Thân', id: 2),
              _buildItemBody(
                svgUrl: ArImages.ic_chi_tren,
                title: 'Chi trên',
                id: 3,
              ),
              _buildItemBody(
                svgUrl: ArImages.ic_chi_duoi,
                title: 'Chi dưới',
                id: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtend() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Mở rộng',
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Những điều thú vị mà bạn nên biết',
            style: OneTheme.of(
              context,
            ).title2.copyWith(fontSize: 14, color: OneColors.textGrey1),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Container();
                    //const TipsScreen(id: 1);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(
                  255,
                  151,
                  184,
                  255,
                ).withOpacity(0.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Có thể bạn chưa biết',
                          style: OneTheme.of(
                            context,
                          ).title2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Các thông tin thú vị về cơ thể con người',
                            style: OneTheme.of(context).title2.copyWith(
                              fontSize: 14,
                              color: OneColors.textGrey1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 80,
                    child: Image.asset(ArImages.co_the_ban_chua_biet),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Container();
                    //const TipsScreen(id: 2);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(
                  255,
                  253,
                  216,
                  115,
                ).withOpacity(0.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cẩm nang sức khỏe',
                          style: OneTheme.of(
                            context,
                          ).title2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Cẩm nang về chăm sóc sức khoẻ',
                            style: OneTheme.of(context).title2.copyWith(
                              fontSize: 14,
                              color: OneColors.textGrey1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: Image.asset(ArImages.co_the_muon_ban_biet),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildItemBody({
    required String svgUrl,
    required String title,
    required int id,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoute.anatomyDetailScreen.name, arguments: [id]);
      },
      child: Column(
        children: [
          SvgPicture.asset(svgUrl),
          const SizedBox(height: 6),
          Text(
            title,
            style: OneTheme.of(context).title2.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _layListDanhSachSearch() {
    layDanhSachDau().then((data) {
      dataList.addAll(data);
    });
    layDanhSachThan().then((data) {
      dataList.addAll(data);
    });
    layDanhSachChiTren().then((data) {
      dataList.addAll(data);
    });
    layDanhSachChiDuoi().then((data) {
      dataList.addAll(data);
    });
  }
}
