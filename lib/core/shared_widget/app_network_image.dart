import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final Widget image = imageUrl.isEmpty
        ? _placeholder()
        : CachedNetworkImage(
            imageUrl: imageUrl,
            width: width ?? 120,
            height: height ?? 70,
            fit: fit,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(height: height, width: width, color: Colors.red),
            ),
            errorWidget: (context, url, error) => _placeholder(),
          );

    return image;
  }

  Widget _placeholder() {
    return placeholder ??
        Image.asset(
          'assets/images/placeholder.png',
          width: width,
          height: height,
          fit: fit,
        );
  }
}



// achedNetworkImage(
//         imageUrl: "http://via.placeholder.com/350x150",
//         placeholder: (context, url) => CircularProgressIndicator(),
//         errorWidget: (context, url, error) => Icon(Icons.error),
//      ),