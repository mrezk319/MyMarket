import 'package:shop_app_2/models/cartModel.dart';

abstract class ProductDetailsStates{}
class InitialGetProductsDetailsState extends ProductDetailsStates{}
class LoadingGetProductsDetailsData extends ProductDetailsStates{}
class SuccessGetProductsDetailsData extends ProductDetailsStates{}
class ErrorGetProductsDetailsData extends ProductDetailsStates{}
class ChangeIndicatorState extends ProductDetailsStates{}

class LoadingCart extends ProductDetailsStates{}
class SuccessCart extends ProductDetailsStates{
  final CartModel cart;
  SuccessCart( this.cart);
}
class ErrorCart extends ProductDetailsStates{}
