import 'dart:convert';

import 'package:doctor_profile_management_application/models/contactModel.dart';
import 'package:http/http.dart' as http;

import '../constant/Constant.dart';

class APICalls {
  static APICalls shared = APICalls();

  Future<List<ContactsData>> getContactsDataList() async {
    var url = TAG_API_URL;
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);

    if (res.statusCode == 200) {
      print(res.statusCode);
      print(res.body);

      final responseJson = jsonDecode(res.body);
      List<ContactsData> directory = [];
      for (var json in responseJson) {
        directory.add(ContactsData.fromJson(json));
      }

      return directory;
    } else {
      return null;
    }
  }
}
