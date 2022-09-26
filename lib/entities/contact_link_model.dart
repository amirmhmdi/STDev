class ContactLinks {
  String? _rel;
  String? _href;

  ContactLinks({String? rel, String? href}) {
    if (rel != null) {
      this._rel = rel;
    }
    if (href != null) {
      this._href = href;
    }
  }

  String? get rel => _rel;
  set rel(String? rel) => _rel = rel;
  String? get href => _href;
  set href(String? href) => _href = href;

  ContactLinks.fromJson(Map<String, dynamic> json) {
    _rel = json['rel'];
    _href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this._rel;
    data['href'] = this._href;
    return data;
  }
}

