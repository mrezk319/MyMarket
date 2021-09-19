import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/models/userModel.dart';
import 'package:shop_app_2/modules/logIn/cubit/logInStates.dart';
import 'package:shop_app_2/modules/signUp/cubit/signUpStates.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/endBoints.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context)=>BlocProvider.of(context);

  UserData? userSignUpData;
  void userSignUp({required String Email,required String Password,required String name,required String phone}){
    emit(SignUpInitialState());
    DioHelper.postData(path: SIGNUP, data: {
      'email':Email,
      'password':Password,
      'name':name,
      'phone':phone,
    },).then((value) {
      userSignUpData = UserData.fromJson(value.data);
      emit(SignUpSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SignUpErrorState());
    });
  }

  bool obsecureText = true;
  void changeObsecureText(){
    obsecureText = !obsecureText;
    emit(cahngeSecureTextSignUp());
  }

}