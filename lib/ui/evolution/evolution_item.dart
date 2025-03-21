import 'package:flutter/material.dart';

import '../../cache_image/cache_image.dart';
import '../../const/ar_theme.dart';


class ItemEvolution extends StatelessWidget {
  const ItemEvolution(
      {super.key,
        required this.title,
        required this.title1,
        required this.descreption,
        required this.imageUrl});

  final String title;
  final String title1;
  final String descreption;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          descreption,
          style: OneTheme.of(context).title1.copyWith(fontSize: 18),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: CachedImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: OneTheme.of(context).title2.copyWith(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
        Text(
          title1,
          style: OneTheme.of(context).title2.copyWith(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}