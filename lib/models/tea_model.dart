class TeaModel {
  int id;
  String name;
  double price;
  String imgURL;
  String brewTime;
  int brewTemp;
  String originCountry;
  String description;

  TeaModel(
      {this.id,
      this.name,
      this.price,
      this.imgURL,
      this.brewTime,
      this.brewTemp,
      this.originCountry,
      this.description});

  TeaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imgURL = json['imgURL'];
    brewTime = json['brewTime'];
    brewTemp = json['brewTemp'];
    originCountry = json['originCountry'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imgURL'] = this.imgURL;
    data['brewTime'] = this.brewTime;
    data['brewTemp'] = this.brewTemp;
    data['originCountry'] = this.originCountry;
    data['description'] = this.description;
    return data;
  }
}
