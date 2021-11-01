import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Shop/layout/homeLayout.dart';
import 'package:Shop/modules/logIn/cubit/logInCubit.dart';
import 'package:Shop/modules/logIn/cubit/logInStates.dart';
import 'package:Shop/modules/signUp/sign_up.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Shop/shared/components/constance.dart';
import 'package:Shop/shared/network/local/cache_helper.dart';
class LogIn extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
   Widget loadOrText = Text("LOG IN",style: TextStyle(color: Colors.white,fontSize: 17),);
   var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LogInCubit(),
      child: BlocConsumer<LogInCubit,LogInStates>(
        builder: (context,state)=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image.asset('assets/images/login.jpg',height: 300,width: 300,fit: BoxFit.cover,),
                          Text("Welcome!",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text("Log in to your existant account",style: TextStyle(fontSize: 16,color: Colors.black26),),
                      SizedBox(height: 15,),
                      Form(
                        child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.purple
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: passwordController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            obscureText: LogInCubit.get(context).obsecureText,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                               icon: LogInCubit.get(context).obsecureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off_outlined),
                                color: Colors.purple,
                                onPressed: (){
                                  LogInCubit.get(context).changeObsecureText();
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.purple,
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              labelText: "Password",

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.purple
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                        key: FormKey,
                      ),
                      Row(children: [
                        Spacer(),
                        TextButton(child: Text("Forgot your password?",style: TextStyle(color: Colors.deepPurpleAccent),),onPressed: (){},),
                      ],),
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.purple),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextButton(onPressed: (){
                              if(FormKey.currentState!.validate())
                              LogInCubit.get(context).userLogIn(Email: emailController.text,Password: passwordController.text);
                            },child: loadOrText,),
                          )),
                      SizedBox(height: 35,),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(child: Text("Sign Up",style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        listener: (context,state){
          if(state is LogInInitialState)
            {
              loadOrText = CircularProgressIndicator(color: Colors.white,);
            }
            else{
            loadOrText =Text("LOG IN",style: TextStyle(color: Colors.white,fontSize: 17),);
          }
            if(state is LogInSuccessState){
              if(LogInCubit.get(context).userData!.status == true){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LogInCubit.get(context).userData!.message),backgroundColor: Colors.green,duration: Duration(seconds: 2),)
                );
                CacheHelper.saveData('token', LogInCubit.get(context).userData!.data!.token);
                Token =  LogInCubit.get(context).userData!.data!.token;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LogInCubit.get(context).userData!.message),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
              }
            }
    },
      ),
    );
  }
}
//ascsss
//asasasas