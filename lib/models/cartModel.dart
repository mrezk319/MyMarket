class CartModel {
  late bool status;
  late String message;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

}
