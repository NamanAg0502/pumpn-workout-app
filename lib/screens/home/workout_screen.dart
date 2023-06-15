import 'package:flutter/material.dart';
import 'package:pumpn/constants/index.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Workout'),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: const Center(
        child: Text('Workout'),
      ),
    );
  }
}
