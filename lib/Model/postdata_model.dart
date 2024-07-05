
class PostDataModel {

  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostDataModel({
      this.name,
      this.uid,
      this.image,
      this.dateTime,
      this.text,
      this.postImage
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "uid": uid,
      "image": image,
      "dateTime": dateTime,
      "text": text,
      "postImage": postImage,
    };
  }

  PostDataModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    uid = json["uid"];
    image = json["image"];
    dateTime = json["dateTime"];
    text = json["text"];
    postImage = json["postImage"];
  }

}
