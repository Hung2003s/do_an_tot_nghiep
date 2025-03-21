// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cache_image/cache_image.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';
import '../../const/constant.dart';
import '../../home/app_router.dart';

class ItemDetailAnotomy extends StatelessWidget {
  const ItemDetailAnotomy({
    Key? key,
    required this.arguments,
    required this.argumentsList,
    required this.title,
  }) : super(key: key);
  final title;
  final arguments;
  final argumentsList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoute.detailScreen.name,
          arguments: [arguments, argumentsList, FromRoute.listItem, title],
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: OneColors.xam,
          boxShadow: [
            BoxShadow(
              color: OneColors.boxshadow..withValues(alpha: 0.3),
              offset: Offset(0, 5),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Hero(
              tag: 'image',
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 90,
                  child: CachedImage(
                    imageUrl: arguments['imageUrl'] ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${arguments['name']}',
              style: OneTheme.of(
                context,
              ).title2.copyWith(fontSize: 18, color: OneColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
