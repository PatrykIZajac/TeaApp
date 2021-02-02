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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imgURL': imgURL,
      'brewTime': brewTime,
      'brewTemp': brewTemp,
      'originCountry': originCountry,
      'description': description
    };
  }

  static List<TeaModel> fromMap(List<Map<String, dynamic>> map) {
    return List.generate(map.length, (i) {
      return TeaModel(
        id: map[i]['id'],
        name: map[i]['name'],
        price: map[i]['price'],
        imgURL: map[i]['imgURL'],
        brewTime: map[i]['brewTime'].toString(),
        brewTemp: map[i]['brewTemp'],
        originCountry: map[i]['originCountry'],
        description: map[i]['description'],
      );
    });
  }

  TeaModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    price = double.parse(json['price'].toString());
    imgURL = json['imgURL'];
    brewTime = json['brewTime'];
    brewTemp = int.parse(json['brewTemp'].toString());
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
