class profileDataModel {
  String? sId;
  String? email;
  String? name;
  String? birthDate;
  String? gender;
  String? number;

  profileDataModel(
      {this.sId,
      this.email,
      this.name,
      this.birthDate,
      this.gender,
      this.number});

  profileDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['number'] = this.number;
    return data;
  }
}