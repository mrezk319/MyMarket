import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_2/layout/homeLayout.dart';
import 'package:shop_app_2/modules/logIn/log_in.dart';
import 'package:shop_app_2/modules/signUp/cubit/signUpStates.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/local/cache_helper.dart';
import 'cubit/signUpCubit.dart';

class SignUp extends StatelessWidget {
  var emailSignUpController = TextEditingController();
  var phoneSignUpController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var nameSignUpController = TextEditingController();
  var passwordAgainSignUpController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  Widget textOrCircular = Text("CREATE",style: TextStyle(color: Colors.white,fontSize: 20),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) =>SignUpCubit(),
        child: BlocConsumer<SignUpCubit,SignUpStates>(
        builder: (context,state)=>SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25,),
                    Text("Let's get started !",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Text("Create an account to get all features",style:TextStyle(fontSize: 15,color: Colors.black26)),
                    SizedBox(height: 25,),
                    Form(
                      key: FormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameSignUpController,
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
                              labelText: "Name",
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
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: emailSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
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
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: phoneSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.purple,
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              labelText: "Phone",
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
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: passwordSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            obscureText: SignUpCubit.get(context).obsecureText,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: SignUpCubit.get(context).obsecureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off_outlined),
                                color: Colors.purple,
                                onPressed: (){
                                  SignUpCubit.get(context).changeObsecureText();
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
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: passwordAgainSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }else if(val != passwordSignUpController.text){
                                return "The password is not the same";
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.purple,
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              labelText: "Confirm Password",
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
                    ),
                    SizedBox(height: 35,),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      minWidth: 150,
                      height: 50,
                      onPressed: (){
                        if(FormKey.currentState!.validate())
                        SignUpCubit.get(context).userSignUp(
                          Password: passwordSignUpController.text,
                          Email: emailSignUpController.text,
                          phone: phoneSignUpController.text,
                          name: nameSignUpController.text);
                      },
                      child: textOrCircular,color: Colors.deepPurple,),
                    SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 17),),
                        TextButton(child: Text("Log In",style: TextStyle(color: Colors.deepPurple,fontSize: 17),),onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
                        },),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          listener: (context,state){
          if(state is SignUpInitialState)
            textOrCircular = CircularProgressIndicator(color:Colors.white);
              else
                textOrCircular = Text("CREATE",style: TextStyle(color: Colors.white,fontSize: 20),);

          if(state is SignUpSuccessState){
            if(SignUpCubit.get(context).userSignUpData!.status == true){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SignUpCubit.get(context).userSignUpData!.message),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
              CacheHelper.saveData('token', SignUpCubit.get(context).userSignUpData!.data!.token);
              Token = SignUpCubit.get(context).userSignUpData!.data!.token;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SignUpCubit.get(context).userSignUpData!.message),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
            }
          }
          },
        ),
      ),
    );
  }
}
