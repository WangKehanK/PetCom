class User {
  int id;
  String username;
  String password;
  String salt;
  String email;
  int type;
  int status;
  String activationCode;

  String headerUrl;
  DateTime createTime;

  User.fromJson(Map<String, dynamic> jsonMap) {
    this.id = int.parse(jsonMap['id']);
    this.username = jsonMap['username'];
    this.password = jsonMap['password'];
    this.salt = jsonMap['salt'];
    this.email = jsonMap['email'];
    this.type = int.parse(jsonMap['type']);
    this.status = int.parse(jsonMap['status']);
    this.activationCode = jsonMap['activationCode'];
    this.headerUrl = jsonMap['headerUrl'];
    this.createTime = DateTime.parse(jsonMap['creatTime']);
  }
}

class Post {
  int id;
  int userId;
  String title;
  String content;
  int type;
  int status;
  DateTime createTime;
  int commentCount;
  double score;

  Post.fromJson(Map<String, dynamic> jsonMap) {
    this.id = int.parse(jsonMap['id']);
    this.userId = int.parse(jsonMap['userId']);
    this.title = jsonMap['title'];
    this.content = jsonMap['content'];
    this.type = int.parse(jsonMap['type']);
    this.status = int.parse(jsonMap['status']);
    this.createTime = DateTime.parse(jsonMap['creatTime']);
    this.commentCount = int.parse(jsonMap['commoentCount']);
    this.score = double.parse(jsonMap['score']);
  }
}

class DiscussPost {
  Post post;
  User user;
}
