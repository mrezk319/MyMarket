import 'package:shop_app_2/models/cartModel.dart';
import 'package:shop_app_2/models/productDetailsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/modules/categoryDetails/cubit/states.dart';
import 'package:shop_app_2/modules/productDetails/cubit/states.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super((InitialGetProductsDetailsState()));

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  ProductDetailsModel? productDetailsModel;
  void getProductDetails(String id){
    emit(LoadingGetProductsDetailsData());
    DioHelper.getData(path: "${PRODUCTSDETAILS+id}", Token: Token).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(SuccessGetProductsDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProductsDetailsData());
    });
  }

  int value = 0;
  void changeVal(val){
    value = val;
    emit(ChangeIndicatorState());
  }

  bool isCart = false;
  CartModel? cartModel;
  void changeCart({required int id}){
    emit(LoadingCart());
    DioHelper.postData(path: CARTS, data: {
      'product_id':id
    },Token: Token).then((value) {
      getProductDetails(id.toString());
      cartModel = CartModel.fromJson(value.data);
      emit(SuccessCart(cartModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorCart());
    });
  }
}