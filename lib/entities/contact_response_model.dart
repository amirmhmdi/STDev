import 'package:stdev_task/entities/contact_data_model.dart';
import 'package:stdev_task/entities/contact_link_model.dart';

class Contact {
  List<ContactLinks>? _lLinks;
  String? _count;
  List<ContactData>? _data;

  Contact({List<ContactLinks>? lLinks, String? count, List<ContactData>? data}) {
    if (lLinks != null) {
      this._lLinks = lLinks;
    }
    if (count != null) {
      this._count = count;
    }
    if (data != null) {
      this._data = data;
    }
  }

  List<ContactLinks>? get lLinks => _lLinks;
  set lLinks(List<ContactLinks>? lLinks) => _lLinks = lLinks;
  String? get count => _count;
  set count(String? count) => _count = count;
  List<ContactData>? get data => _data;
  set data(List<ContactData>? data) => _data = data;

  Contact.fromJson(Map<String, dynamic> json) {
    if (json['_links'] != null) {
      _lLinks = <ContactLinks>[];
      json['_links'].forEach((v) {
        _lLinks!.add(new ContactLinks.fromJson(v));
      });
    }
    _count = json['count'];
    if (json['data'] != null) {
      _data = <ContactData>[];
      json['data'].forEach((v) {
        _data!.add(new ContactData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._lLinks != null) {
      data['_links'] = this._lLinks!.map((v) => v.toJson()).toList();
    }
    data['count'] = this._count;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
