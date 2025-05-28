import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final bool? isProfile;

  const CachedImage({
    Key? key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isProfile == true) {
      return CircleAvatar(
        radius: (width ?? 40) / 2,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImageProvider(imageUrl!)
            : null,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? Icon(Icons.person, size: (width ?? 40) / 2)
            : null,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) =>
          placeholder ?? const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
    );
  }
}
