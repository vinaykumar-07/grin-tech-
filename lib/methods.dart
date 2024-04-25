
import 'package:grin_tech/networkcall_method.dart';
import 'package:http/http.dart';

class ApiCall {
  Future<Response> userDetail(page) {
    String url = 'https://reqres.in/api/users?page=$page';
    Map<String, String> header = Map();
    print('$url');
    //debugPrint(header.toString());
    return NetworkcallMethods().get(url, header);
  }
}
