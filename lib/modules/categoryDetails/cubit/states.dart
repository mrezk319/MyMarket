import 'package:shop_app_2/models/userModel.dart';

abstract class CategoryDetailsStates{}

class InitialGetCAtegoryDetailsData extends CategoryDetailsStates{}

class LoadingGetCAtegoryDetailsData extends CategoryDetailsStates{}
class SuccessGetCAtegoryDetailsData extends CategoryDetailsStates{}
class ErrorGetCAtegoryDetailsData extends CategoryDetailsStates{}