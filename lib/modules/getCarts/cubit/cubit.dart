import 'package:shop_app_2/models/getCartModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/modules/getCarts/cubit/state.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
class AllCartsCubit extends Cubit<AllCartsStates> {
  AllCartsCubit() : super((InitialAllCartsCubit()));

  static AllCartsCubit get(context) => BlocProvider.of(context);

  GetCartModel? getCartModel;
  void getAllCarts(){
    emit(LoadinggetAllCarts());
    DioHelper.getData(path: CARTS, Token: Token).then((value){
      getCartModel = GetCartModel.fromJson(value.data);
      emit(SuccessgetAllCarts());
    }).catchError((error){
      print(error.toString());
      emit(ErrorgetAllCarts());
    });
  }

  void changeCart({required int id}){
    emit(LoadingAllCart());
    DioHelper.postData(path: CARTS, data: {
      'product_id':id
    },Token: Token).then((value) {
      emit(SuccessAllCart());
      getAllCarts();
    }).catchError((error){
      print(error.toString());
      emit(ErrorAllCart());
    });
  }
}