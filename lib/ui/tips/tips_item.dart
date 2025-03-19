import 'package:flutter/material.dart';

import '../../cache_image/cache_image.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import 'detail_screen_tip.dart';

class Item extends StatelessWidget {
  const Item({super.key, this.arguments});

  final arguments;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreenTips(arguments: arguments);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: OneColors.white,
          boxShadow: [
            BoxShadow(
              color: OneColors.shadow.withOpacity(0.2),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedImage(
                    imageUrl: arguments['imageUrl'],
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 8,
                    top: 16,
                  ),
                  child: Text(
                    arguments['title'],
                    style: OneTheme.of(context).title1.copyWith(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: Text(
                    arguments['descreption'],
                    style: OneTheme.of(context).title2.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 15,
              bottom: 10,
              child: Row(
                children: [
                  Text(
                    'Chi tiết',
                    style: OneTheme.of(
                      context,
                    ).title2.copyWith(fontSize: 14, color: OneColors.grey),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: OneColors.grey,
                    size: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
