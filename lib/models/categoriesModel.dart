class CategoriesModel {
  late bool status;
  late DataItem dataAll;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataAll = (json['data'] != null ? new DataItem.fromJson(json['data']) : null)!;
  }
}

class DataItem {
  List<DataCategory> dataList = [];
  DataItem.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList.add(new DataCategory.fromJson(v));
      });
    }

  }
}

class DataCategory {
  late int id;
  late String name;
  late String image;

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
