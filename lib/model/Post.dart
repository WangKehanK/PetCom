class PostResponse {
  String? msg;
  int? code;
  int? totalPage;
  int? currentPage;
  int? total;

  List<Post>? post;

  PostResponse(
      {this.msg,
      this.code,
      this.totalPage,
      this.total,
      this.currentPage,
      this.post});

  PostResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    total = json['total'];

    if (json['post'] != null) {
      post = [];
      json['post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['total'] = this.total;

    if (this.post != null) {
      data['post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int? commentCount;
  String? content;
  int? createTime;
  int? id;
  int? score;
  int? status;
  String? title;
  int? type;
  int? userId;

  Post(
      {this.commentCount,
      this.content,
      this.createTime,
      this.id,
      this.score,
      this.status,
      this.title,
      this.type,
      this.userId});

  Post.fromJson(Map<String, dynamic> json) {
    commentCount = json['commentCount'];
    content = json['content'];
    createTime = json['createTime'];
    id = json['id'];
    score = json['score'];
    status = json['status'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentCount'] = this.commentCount;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['score'] = this.score;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}
