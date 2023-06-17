import 'dart:convert';

import 'package:pumpn/models/exercise_model.dart';

List<Exercise> parseExerciseList(String responseBody) {
  try {
    final dynamic jsonData = jsonDecode(responseBody);
    print(jsonData);

    List<Exercise> exercises = [];

    if (jsonData is List) {
      for (var item in jsonData) {
        final exercise = _parseExercise(item);
        exercises.add(exercise);
      }
    } else if (jsonData is Map) {
      final exercise = _parseExercise(jsonData);
      exercises.add(exercise);
    }

    return exercises;
  } catch (e) {
    print('Error parsing exercise list: $e');
    return [];
  }
}

Exercise _parseExercise(dynamic item) {
  final String category = item['Category'] ?? '';
  final String difficulty = item['Difficulty'] ?? '';
  final String force = item['Force'] ?? '';
  final String exerciseName = item['exercise_name'] ?? '';
  final int id = item['id'] ?? 0;
  final List<String> steps = List<String>.from(item['steps'] ?? []);
  final Map<String, dynamic> target = item['target'] ?? {};
  final List<String> primaryTargets =
      List<String>.from(target['Primary'] ?? []);
  final List<String> secondaryTargets =
      List<String>.from(target['Secondary'] ?? []);
  final List<String> videoURLs = List<String>.from(item['videoURL'] ?? []);
  final String youtubeURL = item['youtubeURL'] ?? '';
  final String details = item['details'] ?? '';
  final String grips = item['Grips'] ?? '';

  return Exercise(
    category: category,
    difficulty: difficulty,
    force: force,
    exerciseName: exerciseName,
    id: id,
    steps: steps,
    primaryTargets: primaryTargets,
    secondaryTargets: secondaryTargets,
    videoURL: videoURLs,
    youtubeURL: youtubeURL,
    details: details,
    grips: grips,
    target: target,
  );
}
