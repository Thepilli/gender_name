import 'package:dio/dio.dart';
import 'package:gender_name/model/gender_name.dart';

class GendernameService {
  Future<GenderName> getGender({
    required String name,
  }) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.genderize.io',
      queryParameters: {
        'name': name,
      },
    ).toString();
    final response = await Dio().get(url);
    return GenderName.fromJson(response.data);
  }
}
