
class UsersMessages {

  String? senderId;
  String? reciverId;
  String? text;
  String? date;

  UsersMessages({
      required this.senderId,
      required this.reciverId,
      required this.text,
      required this.date
  });

  UsersMessages.fromJson(Map<String, dynamic> json) {
    senderId = json["senderId"];
    reciverId = json["reciverId"];
    text = json["text"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "reciverId": reciverId,
      "text": text,
      "date": date,
    };
  }

}
