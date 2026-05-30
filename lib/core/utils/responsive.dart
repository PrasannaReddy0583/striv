import 'package:flutter/material.dart';

/// Scales [size] relative to a 390-pt design baseline.
double scale(BuildContext context, double size) {
  const double baseWidth = 390;
  final double screenWidth = MediaQuery.of(context).size.width;
  return size * (screenWidth / baseWidth);
}
