import 'package:http/http.dart' as http;

class NetworkcallMethods {
  Future<http.Response> get(url, header) async {
    return await http.get(Uri.parse(url), headers: header);
  }
}
