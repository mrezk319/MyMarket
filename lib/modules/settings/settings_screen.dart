import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_2/modules/logIn/cubit/logInCubit.dart';
import 'package:shop_app_2/modules/logIn/log_in.dart';
import 'package:shop_app_2/shared/components/constance.dart';
import 'package:shop_app_2/shared/network/local/cache_helper.dart';

class Settings extends StatelessWidget {
  var emailUpdateController = TextEditingController();
  var nameUpdateController = TextEditingController();
  var phoneUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context){
    emailUpdateController.text = HomeLayoutCubit.get(context).profileModel!.data.email;
    nameUpdateController.text = HomeLayoutCubit.get(context).profileModel!.data.name;
    phoneUpdateController.text = HomeLayoutCubit.get(context).profileModel!.data.phone;
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              if(state is LoadingUpdate)
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: LinearProgressIndicator(color: Colors.purple,),
                ),
              TextFormField(
                controller: nameUpdateController,
                validator: (val) {
                  if (val!.isEmpty) {
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
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.purple)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: emailUpdateController,
                validator: (val) {
                  if (val!.isEmpty) {
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
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.purple)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: phoneUpdateController,
                validator: (val) {
                  if (val!.isEmpty) {
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
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.purple)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(onPressed: (){
                HomeLayoutCubit.get(context).updateData(email: emailUpdateController.text, name: nameUpdateController.text, phone: phoneUpdateController.text);
              }, child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 25),),color: Colors.purple,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              height: 50,
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(onPressed: (){
                CacheHelper.removetData('token');
                Token = '';
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
              }, child: Text("Sign Out",style: TextStyle(color: Colors.white,fontSize: 25),),color: Colors.purple,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                height: 50,
              ),
            ],
          ),
        ),
        listener: (context, state) {
          if(state is SuccessUpdate){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Succesfully"),backgroundColor: Colors.green,duration: Duration(milliseconds: 350),));
          }
        },
    );
  }
}
