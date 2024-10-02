class Chef_Register_Model {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? uid;
  String? bio;

  Chef_Register_Model(
      {this.name, this.email, this.password, this.gender,this.bio, this.uid});

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "gender": gender,
      "bio":bio,
      "uid": uid
    };
  }
}
