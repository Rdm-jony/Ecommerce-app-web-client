class userDataModel {
  String? sId;
  String? email;
  String? name;
  String? birthDate;
  String? gender;
  String? number;
  String? role;
  String? image;

  userDataModel(
      {this.sId,
      this.email,
      this.name,
      this.birthDate,
      this.gender,
      this.number,
      this.role,
      this.image});

  userDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    number = json['number'];
    role = json['role'];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['number'] = this.number;
    data['role'] = this.role;
    data["image"] = this.image;
    return data;
  }
}
