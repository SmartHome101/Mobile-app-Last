import 'package:http/http.dart' as http;

class SRApiClient {
  Future<String> uploadAudio(filePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://sr.techome.systems/predict'));

    var audio = await http.MultipartFile.fromPath('file', filePath);
    request.files.add(audio);

    var response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);

      var body = res.body;

      return body;
    } else {
      throw Exception('Failed to load sr Result');
    }
  }
}
