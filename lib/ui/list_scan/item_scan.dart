import 'package:flutter/material.dart';
import 'package:native_ar_viewer/native_ar_viewer.dart';
import 'dart:io' as io;

import '../../cache_image/cache_image.dart';
import '../../const/ar_color.dart';
import '../../const/ar_theme.dart';

class ItemScanAr extends StatefulWidget {
  const ItemScanAr({super.key, required this.title, required this.descreption, required this.imageUrl, required this.image3d, required this.index});
  final int index;
  final String title;
  final String descreption;
  final String imageUrl;
  final String image3d;

  @override
  State<ItemScanAr> createState() => _ItemScanArState();
}

class _ItemScanArState extends State<ItemScanAr> {
  _launchAR(String model3DUrl) async {
    if (io.Platform.isAndroid) {
      await NativeArViewer.launchAR(model3DUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Platform not supported')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          _launchAR(widget.image3d);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.index % 2 == 0 ? const Color.fromARGB(255, 255, 240, 221) : const Color.fromARGB(255, 221, 226, 255),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: OneTheme.of(context).title1.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.descreption,
                    style: OneTheme.of(context).title2.copyWith(fontSize: 14, color: OneColors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: CachedImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}