import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  //create the method to save user
  Future<http.Response> saveUser(
      String name, String mobile, String email, String address) async {
    //create uri
    var uri = Uri.parse("http://localhost:8081/register");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'address': address,
    };
    // convert the above data into json
    var body = json.encode(data);
    print(body);
    var response = await http.post(uri, headers: headers, body: body);

    // print the response body
    print(response.body);

    return response;
  }
}
