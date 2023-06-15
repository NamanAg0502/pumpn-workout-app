import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pumpn/constants/data.dart';
import 'package:pumpn/constants/index.dart';
import 'package:pumpn/models/exercise_model.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  List<Exercise> exercises = [];
  final selectedTarget = TextEditingController();
  final selectedEquipment = TextEditingController();
  final selectedBodyPart = TextEditingController();
  final selectedMuscle = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }

    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];
      if (word.isNotEmpty) {
        words[i] = word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }

  Future<void> fetchData() async {
    const baseUrl = 'https://exercisedb.p.rapidapi.com/exercises';
    const apiKey = '54dd53cd39msh1d5c2fe53afdae6p14dc51jsn18f01b0fe411';

    final queryParameters = <String, String>{};

    if (selectedTarget.text.isNotEmpty) {
      queryParameters['target'] = selectedTarget.text;
    }
    if (selectedEquipment.text.isNotEmpty) {
      queryParameters['equipment'] = selectedEquipment.text;
    }
    if (selectedBodyPart.text.isNotEmpty) {
      queryParameters['bodyPart'] = selectedBodyPart.text;
    }

    String url = baseUrl;

    if (selectedBodyPart.text.isNotEmpty) {
      url = '$baseUrl/bodyPart/${Uri.encodeComponent(selectedBodyPart.text)}';
    } else if (selectedTarget.text.isNotEmpty) {
      url = '$baseUrl/target/${Uri.encodeComponent(selectedTarget.text)}';
    } else if (selectedEquipment.text.isNotEmpty) {
      url = '$baseUrl/equipment/${Uri.encodeComponent(selectedEquipment.text)}';
    }

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    final response = await http.get(
      uri,
      headers: {'X-RapidAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      setState(() {
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
                    controller: selectedTarget,
                    items: ItemData.targetItems,
                    fillColor: Colors.grey[900],
                    hintStyle: TextStyle(color: AppColors.white),
                    hintText: 'Target',
                    fieldSuffixIcon: const Icon(Icons.arrow_drop_down,
                        color: AppColors.white),
                    onChanged: (value) => fetchData(),
                    listItemBuilder: (context, result) => Text(
                          capitalize(result),
                          style: const TextStyle(color: AppColors.black),
                        )),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomDropdown(
                  controller: selectedEquipment,
                  items: ItemData.equipmentItems,
                  fillColor: Colors.grey[900],
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                  hintStyle: TextStyle(color: AppColors.white),
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  hintText: 'Equipment',
                  onChanged: (value) => fetchData(),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomDropdown(
                  controller: selectedBodyPart,
                  items: ItemData.bodyPartItems,
                  fillColor: Colors.grey[900],
                  listItemBuilder: (context, result) => Text(
                    capitalize(result),
                    style: const TextStyle(color: AppColors.black),
                  ),
                  hintText: 'Body Part',
                  hintStyle: TextStyle(color: AppColors.white),
                  fieldSuffixIcon:
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                  onChanged: (value) => fetchData(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          exercises[index].gifUrl,
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalize(exercises[index].name),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.purple.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    exercises[index].bodyPart,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.red.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    exercises[index].target,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                exercises[index].equipment,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(exercises[index]);
                        },
                        icon: const Icon(Icons.add, color: AppColors.orange),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Exercise> parseExerciseList(String responseBody) {
  try {
    final List<dynamic> jsonData = jsonDecode(responseBody);
    print(jsonData);

    List<Exercise> exercises = [];

    for (var item in jsonData) {
      final String name = item['name'];
      final String bodyPart = item['bodyPart'];
      final String equipment = item['equipment'];
      final String gifUrl = item['gifUrl'];
      final String id = item['id'];
      final String target = item['target'];

      final Exercise exercise = Exercise(
        name: name,
        bodyPart: bodyPart,
        equipment: equipment,
        gifUrl: gifUrl,
        id: id,
        target: target,
      );
      exercises.add(exercise);
    }

    return exercises;
  } catch (e) {
    print('Error parsing exercise list: $e');
    return [];
  }
}
