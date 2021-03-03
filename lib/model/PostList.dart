class PostList {
  Post post;
  User user;

  PostList({this.post, this.user});

  PostList.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Post {
  int id;
  int userId;
  String title;
  String content;
  int type;
  int status;
  String createTime;
  int commentCount;
  double score;

  Post(
      {this.id,
      this.userId,
      this.title,
      this.content,
      this.type,
      this.status,
      this.createTime,
      this.commentCount,
      this.score});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    status = json['status'];
    createTime = json['createTime'];
    commentCount = json['commentCount'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['commentCount'] = this.commentCount;
    data['score'] = this.score;
    return data;
  }
}

class User {
  int id;
  String username;
  String password;
  String salt;
  String email;
  int type;
  int status;
  Null activationCode;
  String headerUrl;
  String createTime;

  User(
      {this.id,
      this.username,
      this.password,
      this.salt,
      this.email,
      this.type,
      this.status,
      this.activationCode,
      this.headerUrl,
      this.createTime});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    salt = json['salt'];
    email = json['email'];
    type = json['type'];
    status = json['status'];
    activationCode = json['activationCode'];
    headerUrl = json['headerUrl'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['email'] = this.email;
    data['type'] = this.type;
    data['status'] = this.status;
    data['activationCode'] = this.activationCode;
    data['headerUrl'] = this.headerUrl;
    data['createTime'] = this.createTime;
    return data;
  }
}
