import 'package:http/http.dart' as http;
import 'package:pumpn/models/exercise_model.dart';
import '../utils/json_parser.dart';

class ExerciseService {
  static Future<List<Exercise>> fetchExercises({
    String? difficulty,
    String? category,
    String? bodyPart,
  }) async {
    const baseUrl = 'https://exercisedb.p.rapidapi.com/exercises';
    const apiKey = '54dd53cd39msh1d5c2fe53afdae6p14dc51jsn18f01b0fe411';

    final queryParameters = <String, String>{};

    if (difficulty != null && difficulty.isNotEmpty) {
      queryParameters['target'] = difficulty;
    }
    if (category != null && category.isNotEmpty) {
      queryParameters['equipment'] = category;
    }
    if (bodyPart != null && bodyPart.isNotEmpty) {
      queryParameters['bodyPart'] = bodyPart;
    }

    String url = baseUrl;

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    final response = await http.get(
      uri,
      headers: {'X-RapidAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      return parseExerciseList(response.body);
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return [];
    }
  }
}
