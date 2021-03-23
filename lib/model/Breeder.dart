class BreederList {
  String? msg;
  int? code;
  int? totalPage;
  int? currentPage;
  List<Breeder>? breeder;

  BreederList(
      {this.msg, this.code, this.totalPage, this.currentPage, this.breeder});

  BreederList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    if (json['breeder'] != null) {
      // breeder = new List<Breeder>();
      breeder = [];
      json['breeder'].forEach((v) {
        breeder!.add(new Breeder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    if (this.breeder != null) {
      data['breeder'] = this.breeder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Breeder {
  String? address;
  String? city;
  String? contact;
  int? createTime;
  String? description;
  int? id;
  double? score;
  String? state;
  String? title;
  int? type;
  String? website;

  Breeder(
      {this.address,
      this.city,
      this.contact,
      this.createTime,
      this.description,
      this.id,
      this.score,
      this.state,
      this.title,
      this.type,
      this.website});

  Breeder.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    contact = json['contact'];
    createTime = json['createTime'];
    description = json['description'];
    id = json['id'];
    score = json['score'];
    state = json['state'];
    title = json['title'];
    type = json['type'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['contact'] = this.contact;
    data['createTime'] = this.createTime;
    data['description'] = this.description;
    data['id'] = this.id;
    data['score'] = this.score;
    data['state'] = this.state;
    data['title'] = this.title;
    data['type'] = this.type;
    data['website'] = this.website;
    return data;
  }
}
