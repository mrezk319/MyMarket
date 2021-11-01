import 'package:flutter/material.dart';
import 'package:Shop/layout/homeLayout.dart';
import 'package:Shop/modules/logIn/log_in.dart';
import 'package:Shop/shared/components/constance.dart';
import 'package:Shop/shared/network/local/cache_helper.dart';
import 'package:Shop/shared/network/remote/dio_helper.dart';
import 'blocObserver.dart';
import 'layout/cubit/home_layout_cubit.dart';
import 'modules/onBoarding/on_boarding.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>HomeLayoutCubit()),
        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startApp,
        ));
  }
}