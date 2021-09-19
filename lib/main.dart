import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app_2/layout/homeLayout.dart';
import 'package:shop_app_2/modules/logIn/log_in.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/local/cache_helper.dart';
import 'package:shop_app_2/shared/network/remote/dio_helper.dart';
import 'blocObserver.dart';
import 'modules/onBoarding/on_boarding.dart';
import 'package:bloc/bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = CacheHelper.getData('onBoarding');
  Token = CacheHelper.getData('token');
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();

  late Widget start;
  if(onBoardingFinish != null){
    if(Token == null){
      start = LogIn();
    }else{
      start = HomeLayout();
    }
  }else
    start = OnBoarding();
  runApp(MyApp(start));
}
class MyApp extends StatelessWidget {
  Widget startApp;
  MyApp(this.startApp);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startApp,
    );
  }
}