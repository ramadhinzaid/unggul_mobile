import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AtomEmptyList extends StatelessWidget {
  const AtomEmptyList({
    super.key,
    this.height,
    this.width,
    this.fit,
    this.label,
    this.message,
  });

  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? label;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/empty.json',
          repeat: false,
          width: width,
          height: height,
          fit: fit,
        ),
        Text(
          message ?? 'belum ada ${label ?? 'data'}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
