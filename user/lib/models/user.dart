class User {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? is_Active;

  User({ this.id, this.name, this.email, this.password, this.is_Active});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      is_Active: json['is_Active'] as bool,
    );
  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ;
    data['name'] = this.name ;
    data['email'] = this.email ;
    data['password'] = this.password ;
    data['is_Active'] = this.is_Active ;
    return data;
  }
}
