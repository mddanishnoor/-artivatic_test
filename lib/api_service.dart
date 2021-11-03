import 'dart:convert';

import 'package:api_call/data_modal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

  Future<List<DataModal>> fetchData() async {
    var response = await http.get(url);
    List<DataModal> data = [];

    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      for (var user in decodedJson) {
        data.add(DataModal.fromData(user));
      }

      // print(data);
      return data;
    } else {
      print("Failed" + response.statusCode.toString());
      return data;
    }
  }
}
