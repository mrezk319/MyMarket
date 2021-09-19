import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/models/userModel.dart';
import 'package:shop_app_2/modules/logIn/cubit/logInStates.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
class LogInCubit extends Cubit<LogInStates>{
  LogInCubit() : super(LogInInitialState());

  static LogInCubit get(context)=>BlocProvider.of(context);

  UserData? userData;
  void userLogIn({required String Email,required String Password}){
    emit(LogInInitialState());
    DioHelper.postData(path: LOGIN, data: {
      'email':Email,
      'password':Password,
    }).then((value) {
      userData = UserData.fromJson(value.data);
      emit(LogInSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LogInErrorState());
    });
  }

  bool obsecureText = true;
  void changeObsecureText(){
    obsecureText = !obsecureText;
    emit(cahngeSecureText());
  }

}