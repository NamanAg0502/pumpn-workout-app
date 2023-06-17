import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pumpn/constants/data.dart';
import 'package:pumpn/constants/index.dart';
import 'package:pumpn/models/exercise_model.dart';
import 'package:pumpn/screens/workout/exercise_details_page.dart';
import 'package:pumpn/utils/capatalize.dart';
import 'package:pumpn/utils/json_parser.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  List<Exercise> exercises = [];
  final selectedCategory = TextEditingController();
  final selectedDifficulty = TextEditingController();
  final selectedForce = TextEditingController();
  final selectedMuscle = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _navigateToExerciseDetail(Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailPage(exercise: exercise),
      ),
    );
  }

  Future<void> fetchData() async {
    const baseUrl = 'https://musclewiki.p.rapidapi.com/exercises';
    const apiKey = '54dd53cd39msh1d5c2fe53afdae6p14dc51jsn18f01b0fe411';

    final queryParameters = <String, String>{};

    if (selectedCategory.text.isNotEmpty) {
      queryParameters['category'] = selectedCategory.text;
    }
    if (selectedDifficulty.text.isNotEmpty) {
      queryParameters['difficulty'] = selectedDifficulty.text;
    }
    if (selectedForce.text.isNotEmpty) {
      queryParameters['force'] = selectedForce.text;
    }
    if (selectedMuscle.text.isNotEmpty) {
      queryParameters['muscle'] = selectedMuscle.text;
    }

    String url = baseUrl;

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    print(uri);

    final response = await http.get(
      uri,
      headers: {'X-RapidAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        exercises = parseExerciseList(response.body);
      });
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Exercise Screen'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  controller: selectedCategory,
                  items: ItemData.categories,
                  fillColor: Colors.grey[900],
                  hintStyle: const TextStyle(color: AppColors.white),
                  hintText: 'Category',
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  onChanged: (value) => fetchData(),
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomDropdown(
                  controller: selectedDifficulty,
                  items: ItemData.difficulties,
                  fillColor: Colors.grey[900],
                  hintStyle: const TextStyle(color: AppColors.white),
                  hintText: 'Difficulty',
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  onChanged: (value) => fetchData(),
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  controller: selectedForce,
                  items: ItemData.forces,
                  fillColor: Colors.grey[900],
                  hintStyle: const TextStyle(color: AppColors.white),
                  hintText: 'Force',
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  onChanged: (value) => fetchData(),
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomDropdown(
                  controller: selectedMuscle,
                  items: ItemData.muscles,
                  fillColor: Colors.grey[900],
                  hintStyle: const TextStyle(color: AppColors.white),
                  hintText: 'Muscle',
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  onChanged: (value) => fetchData(),
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return ListTile(
                  onTap: () => _navigateToExerciseDetail(exercise),
                  title: Text(exercise.exerciseName),
                  subtitle: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise.category),
                      Text(exercise.difficulty),
                      Text(exercise.force),
                      Text(exercise.target[0] ?? ''),
                    ],
                  )),
                  // leading: exercise.videoURL.isNotEmpty
                  //     ? Image.network(exercise.videoURL[0])
                  //     : Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
