class TopProductDataModel {
  String? sId;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;
  bool? top;
  bool? ads;
  bool? paid;

  TopProductDataModel(
      {this.sId,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.top,
      this.ads,
      this.paid});

  TopProductDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    top = json['top'];
    ads = json['ads'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    data["top"] = this.top;
    data["ads"] = this.ads;
    data['paid'] = this.paid;
    return data;
  }
}
