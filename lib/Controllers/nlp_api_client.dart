import 'dart:convert';
import '../model/nlp_module.dart';
import 'package:http/http.dart' as http;

class NLPApiClient {
  Future<NLPResult> getTextResult(body) async {
    var endpointUrl = 'http://nlp.techome.systems';

    final uri = Uri.parse('$endpointUrl/predict').replace(queryParameters: {
      'message': body,
    });

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      return NLPResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load NLPResult');
    }
  }
}
