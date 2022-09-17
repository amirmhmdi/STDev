import 'dart:io';

class Contact {
  String? _sId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _notes;
  // File? _picture;
  String? _phone;

  Contact({
    String? sId,
    String? firstName,
    String? lastName,
    String? email,
    String? notes,
    // File? picture,
    String? phone,
  }) {
    if (sId != null) {
      this._sId = sId;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
    if (email != null) {
      this._email = email;
    }
    if (notes != null) {
      this._notes = notes;
    }
    // if (picture != null) {
    //   this._picture = picture;
    // }
    if (phone != null) {
      this._phone = phone;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get notes => _notes;
  set notes(String? notes) => _notes = notes;
  // File? get picture => _picture;
  // set picture(File? picture) => _picture = picture;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;

  Contact.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _notes = json['notes'];
    // _picture = json['picture'].cast<String>();
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['email'] = this._email;
    data['notes'] = this._notes;
    // data['picture'] = this._picture;
    data['phone'] = this._phone;
    return data;
  }
}
