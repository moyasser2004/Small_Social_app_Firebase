
class UserDataModel {

  String? name;
  String? email;
  String? uId;
  String? password;
  String? coverImage;
  String? prImage;
  String? bio;

  UserDataModel(
      {required this.name,
      required this.email,
      required this.uId,
      required this.password,
      this.coverImage,
      this.prImage,
      this.bio});
  
  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    uId = json["uId"];
    password = json["password"];
    coverImage = json["image"];
    prImage = json["prImage"];
    bio = json["bio"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "password": password,
      "coverImage": coverImage,
      "prImage": prImage,
      "bio": bio,
    };
  }

}
