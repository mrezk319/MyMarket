import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/models/categoriesModel.dart';
import 'package:shop_app_2/models/categoryDetailsModel.dart';
import 'package:shop_app_2/models/getCartModel.dart';
import 'package:shop_app_2/models/getFavoritesModel.dart';
import 'package:shop_app_2/models/homeModel.dart';
import 'package:shop_app_2/models/productDetailsModel.dart';
import 'package:shop_app_2/models/profileModel.dart';
import 'package:shop_app_2/models/searchModel.dart';
import 'package:shop_app_2/models/userModel.dart';
import 'package:shop_app_2/modules/categories/categories_screen.dart';
import 'package:shop_app_2/modules/favorite/favorite_screen.dart';
import 'package:shop_app_2/modules/home/home_screen.dart';
import 'package:shop_app_2/modules/logIn/cubit/logInStates.dart';
import 'package:shop_app_2/modules/settings/settings_screen.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';

import 'home_layout_states.dart';
class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context)=>BlocProvider.of(context);

  HomeModel? homeModel;
  void getHomeData(){
    emit(LoadingGetHomeData());
    DioHelper.getData(path: HOME, Token: Token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((e) {
        isFavorite.addAll({e.id:e.inFavorites});
      });
      emit(SuccessGetHomeData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetHomeData());
    });
  }

  List<Widget> Screens = [
    Home(),
    Categories(),
    Favorites(),
    Settings(),
  ];
  int indexBottomNavBar = 0;
  void changeIndexBottom(int x){
    indexBottomNavBar = x;
    emit(BottomNavBarChanged());
  }
  
  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(LoadingGetCategoriesData());
    DioHelper.getData(path: CATEGORIES, Token: Token).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessGetCategoriesData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCategoriesData());
    });
  }

  Map<int,bool> isFavorite ={};

  UserData? favoriteData;
  void changeFavorite({required int id}){
    emit(LoadingChangeFav());
    DioHelper.postData(path: FAVORITE, data: {
      'product_id':id
    },Token: Token).then((value) {
      isFavorite[id] = !(isFavorite[id]??false);
      favoriteData = UserData.fromJson(value.data);
      emit(SuccessChangeFav(favoriteData!));
    }).catchError((error){
      emit(ErrorChangeFav());
    });
  }

  FavoriteGetModel? getFavoritesModel;
  void getFavorite(){
    emit(LoadingGetFavoritesData());
    DioHelper.getData(path: FAVORITE, Token: Token).then((value){
      getFavoritesModel = FavoriteGetModel.fromJson(value.data);
      emit(SuccessGetFavoritesData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetFavoritesData());
    });
  }

  SearchModel? searchModel;
  void getSearchProduct({required String txt}){
    emit(LoadingSearch());
    DioHelper.postData(path: SEARCH, data: {
      'text':txt
    },Token: Token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data.data.length);
      emit(SuccessSearch());
    }).catchError((error){
      emit(ErrorSearch());
    });
  }

  ProfileModel? profileModel;
  void getProfile(){
    emit(LoadingGetProfilesData());
    DioHelper.getData(path: PROFILE, Token: Token).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProfileData());
    });
  }

  void updateData({required String email,required String name,required String phone,}){
    emit(LoadingUpdate());
    DioHelper.putData(path: UPDATE, data: {
      'name':name,
      'email':email,
      'phone':phone,
    },Token: Token).then((value) {
      getProfile();
      emit(SuccessUpdate());
    }).catchError((error){
      emit(ErrorUpdate());
    });
  }
}