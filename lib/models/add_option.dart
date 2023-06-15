import 'package:flutter/material.dart';
import 'package:pumpn/constants/index.dart';

class AddOptions {
  final String name;
  final String icon;
  final String route;
  late Color color;

  AddOptions({
    required this.route,
    required this.name,
    required this.icon,
    Color? color,
  }) {
    this.color = color ?? AppColors.orange;
  }
}
