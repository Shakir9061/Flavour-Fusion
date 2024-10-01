class Chef_Register_Model {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? uid;

  Chef_Register_Model(
      {this.name, this.email, this.password, this.gender, this.uid});

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "gender": gender,
      "uid": uid
    };
  }
}
