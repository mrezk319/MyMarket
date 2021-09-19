
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_states.dart';
import 'package:shop_app_2/models/categoriesModel.dart';
import 'package:shop_app_2/modules/categoryDetails/category_details.dart';
class Categories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        builder:(context,state)=> HomeLayoutCubit.get(context).homeModel == null || HomeLayoutCubit.get(context).categoriesModel == null? Center(child: CircularProgressIndicator(color: Colors.purple,)) : ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>categoriesView(HomeLayoutCubit.get(context).categoriesModel,index,context), separatorBuilder: (context,index)=>Divider(height: 2,color: Colors.deepPurpleAccent,indent: 25,endIndent: 25,), itemCount: HomeLayoutCubit.get(context).categoriesModel!.dataAll.dataList.length),
        listener: (context,state){}
    );
  }
}
Widget categoriesView(CategoriesModel? model,index,context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image.network(model!.dataAll.dataList[index].image,height: 100,width: 120,),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(model.dataAll.dataList[index].name,style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 17,fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        IconButton(
            onPressed: (){
              print(model.dataAll.dataList[index].id);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetails(id: model.dataAll.dataList[index].id)));
        }, icon: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple,)),
      ],),
  );
}