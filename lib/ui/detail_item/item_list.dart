// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../cache_image/cache_image.dart';
import '../../const/ar_theme.dart';

class ItemListAnotomy extends StatefulWidget {
  const ItemListAnotomy({
    super.key,
    required this.arguments,
    required this.argumentsList,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  final arguments;
  final argumentsList;
  final imageUrl;
  final name;
  final Function? onTap;

  @override
  State<ItemListAnotomy> createState() => _ItemListAnotomyState();
}

class _ItemListAnotomyState extends State<ItemListAnotomy> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 51,
              child: CachedImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              '${widget.name}',
              style: OneTheme.of(context).title2.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
