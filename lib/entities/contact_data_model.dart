class ContactData {
  String? _id;
  String? _firstName;
  String? _notes;
  String? _phone;
  String? _email;
  List<String>? _picture;
  String? _lastName;
  String? _createdAt;

  ContactData({String? id, String? firstName, String? notes, String? phone, String? email, List<String>? picture, String? lastName, String? createdAt}) {
    if (id != null) {
      this._id = id;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (notes != null) {
      this._notes = notes;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (email != null) {
      this._email = email;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get notes => _notes;
  set notes(String? notes) => _notes = notes;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;
  List<String>? get picture => _picture;
  set picture(List<String>? picture) => _picture = picture;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  ContactData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _notes = json['notes'];
    _phone = json['phone'];
    _email = json['email'];
    _picture = json.containsKey('picture') ? json['picture'].cast<String>() : [""];
    _lastName = json['lastName'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['firstName'] = this._firstName;
    data['notes'] = this._notes;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['picture'] = this._picture;
    data['lastName'] = this._lastName;
    data['created_at'] = this._createdAt;
    return data;
  }
}
