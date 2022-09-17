import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stdev_task/entities/constants/api_url.dart';
import 'package:stdev_task/entities/contact_model.dart';

class ContactRepository {
  Map<String, String>? _header = {
    "x-apikey": ApiUrl.apiToken,
    "accept": "application/json",
  };

  Future<http.Response> loadContact() async {
    http.Response response = await http.get(Uri.parse(ApiUrl.contactUrl), headers: _header);

    return response;
  }

  Future<http.Response> editContact(Contact editedContact) async {
    http.Response response = await http.patch(Uri.parse(ApiUrl.contactUrl), body: jsonEncode(editedContact.toJson()), headers: _header);

    return response;
  }

  Future<http.Response> deleteContact(String editedContactId) async {
    http.Response response = await http.delete(Uri.parse(ApiUrl.contactUrl), body: editedContactId, headers: _header);

    return response;
  }
}
