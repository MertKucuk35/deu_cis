import 'package:cached_network_image/cached_network_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';

class ImageZoomDialog extends StatelessWidget {
  ImageZoomDialog({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(52),
        child: Stack(
          children: [
            Positioned(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.width * 0.85,
                  width: MediaQuery.of(context).size.width * 0.85,
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColors.themeColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 4,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
