import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stdev_task/entities/constants/api_url.dart';
import 'package:stdev_task/entities/contact_data_model.dart';
import 'package:stdev_task/entities/contact_response_model.dart';

class ContactRepository {
  Map<String, String>? _header = {"accept": "application/json", "x-endpoint-key": ApiUrl.apiToken};

  Future<http.Response> loadContact() async {
    http.Response? response;
    try {
      response = await http.get(Uri.parse(ApiUrl.contactUrl), headers: _header);
    } catch (e) {
      print(e);
    }

    return response!;
  }

  Future<http.Response> addContact(ContactData contact) async {
    String body = jsonEncode(contact.toJson());
    http.Response? response;
    try {
      response = await http.post(Uri.parse(ApiUrl.contactUrl), body: body, headers: _header);
    } catch (e) {
      print(e);
    }

    return response!;
  }

  Future<http.Response> editContact(ContactData editedContact) async {
    String url = "${ApiUrl.contactUrl}/${editedContact.id!}";
    String a = jsonEncode(editedContact.toJson());
    http.Response response = await http.put(
      Uri.parse(url),
      body: a,
      headers: _header,
    );

    return response;
  }

  Future<http.Response> deleteContact(String editedContactId) async {
    http.Response response = await http.delete(Uri.parse(ApiUrl.contactUrl), body: editedContactId, headers: _header);

    return response;
  }
}
