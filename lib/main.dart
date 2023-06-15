import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pumpn/screens/home/bottom_navigation_screen.dart';
import 'package:pumpn/screens/splash_screen.dart';
import 'package:pumpn/screens/workout/create_workout_screen.dart';
import 'package:pumpn/utils/theme_utils.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const BottomNavigationScreen(),
        '/create-workout': (context) => const CreateWorkoutScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
