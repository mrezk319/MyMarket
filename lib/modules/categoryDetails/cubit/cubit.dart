import 'package:shop_app_2/models/categoryDetailsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/models/getFavoritesModel.dart';
import 'package:shop_app_2/models/userModel.dart';
import 'package:shop_app_2/modules/categoryDetails/cubit/states.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit() : super((InitialGetCAtegoryDetailsData()));

  static CategoryDetailsCubit get(context) => BlocProvider.of(context);



  CategoryDetailsModel? categoyDetails;
  void getCategoryDetail({
    required int? catId
  }){
    emit(LoadingGetCAtegoryDetailsData());
    DioHelper.getData(path: PRODUCTS, Token: Token,data: {
      'category_id':catId,
    }).then((value){
      print(value.data);
      categoyDetails = CategoryDetailsModel.fromJson(value.data);
      print(categoyDetails!.data.data[0].id);
      emit(SuccessGetCAtegoryDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCAtegoryDetailsData());
    });
  }


}