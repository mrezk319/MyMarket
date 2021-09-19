class CategoryDetailsModel {
  late bool status;
  late Data data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  List<DataCAte> data = [];
  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new DataCAte.fromJson(v));
      });
    }
  }

}

class DataCAte {
  late int id;
  late final price;
  late final oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  List<String> images =[];
  late bool inFavorites;
  late bool inCart;

  DataCAte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
