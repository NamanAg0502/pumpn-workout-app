class Exercise {
  final String category;
  final String difficulty;
  final String force;
  final String grips;
  final String details;
  final String exerciseName;
  final int id;
  final List<String> steps;
  final Map<String, dynamic> target;
  final List<String> primaryTargets;
  final List<String> secondaryTargets;
  final List<String> videoURL;
  final String youtubeURL;

  Exercise({
    required this.category,
    required this.difficulty,
    required this.force,
    required this.grips,
    required this.details,
    required this.exerciseName,
    required this.id,
    required this.steps,
    required this.target,
    required this.primaryTargets,
    required this.secondaryTargets,
    required this.videoURL,
    required this.youtubeURL,
  });
}
