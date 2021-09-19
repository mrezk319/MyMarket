import 'package:shop_app_2/models/userModel.dart';

abstract class HomeLayoutStates{}
class HomeLayoutInitialState extends HomeLayoutStates{}
class ChangeIndexHomeState extends HomeLayoutStates{}

class LoadingGetHomeData extends HomeLayoutStates{}
class SuccessGetHomeData extends HomeLayoutStates{}
class ErrorGetHomeData extends HomeLayoutStates{}


class BottomNavBarChanged extends HomeLayoutStates{}

class LoadingGetCategoriesData extends HomeLayoutStates{}
class SuccessGetCategoriesData extends HomeLayoutStates{}
class ErrorGetCategoriesData extends HomeLayoutStates{}

class LoadingChangeFav extends HomeLayoutStates{}
class SuccessChangeFav extends HomeLayoutStates{
  final UserData user;
  SuccessChangeFav(this.user);
}
class ErrorChangeFav extends HomeLayoutStates{}

class LoadingGetFavoritesData extends HomeLayoutStates{}
class SuccessGetFavoritesData extends HomeLayoutStates{}
class ErrorGetFavoritesData extends HomeLayoutStates{}


class LoadingSearch extends HomeLayoutStates{}
class SuccessSearch extends HomeLayoutStates{}
class ErrorSearch extends HomeLayoutStates{}

class LoadingGetProfilesData extends HomeLayoutStates{}
class SuccessGetProfileData extends HomeLayoutStates{}
class ErrorGetProfileData extends HomeLayoutStates{}

class LoadingUpdate extends HomeLayoutStates{}
class SuccessUpdate extends HomeLayoutStates{}
class ErrorUpdate extends HomeLayoutStates{}