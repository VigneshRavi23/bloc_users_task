class Users {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserData>? data;
  Support? support;

  Users({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: (json['data'] as List<dynamic>)
          .map((userData) => UserData.fromJson(userData))
          .toList(),
      support: Support.fromJson(json['support']),
    );
  }
}

class UserData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }
}
