import 'package:flutter/material.dart';
import 'package:pumpn/constants/index.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: const Text('Explore Screen',
              style: TextStyle(color: AppColors.white)),
        ));
  }
}
