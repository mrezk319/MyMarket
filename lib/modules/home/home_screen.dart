import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_states.dart';
import 'package:shop_app_2/models/categoriesModel.dart';
import 'package:shop_app_2/models/homeModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app_2/modules/categoryDetails/category_details.dart';
import 'package:shop_app_2/modules/productDetails/product_details.dart';
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        builder:(context,state)=> HomeLayoutCubit.get(context).homeModel == null || HomeLayoutCubit.get(context).categoriesModel == null? Center(child: CircularProgressIndicator(color: Colors.purple,)) : HomeView(HomeLayoutCubit.get(context).homeModel,HomeLayoutCubit.get(context).categoriesModel,HomeLayoutCubit.get(context).isFavorite,context),

        listener: (context,state){
          if(state is SuccessChangeFav){
            HomeLayoutCubit.get(context).getFavorite();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.user.message),backgroundColor: Colors.green,duration: Duration(milliseconds: 450),));
          }
        }
    );
  }
}
Widget HomeView(HomeModel? modelHome,CategoriesModel? modelCat,Map<int,bool> fav,context) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      SizedBox(height: 15,),
      bannersView(modelHome!),
      SizedBox(height: 15,),
      Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      SizedBox(height: 15,),
      Container(
        height: 100,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)=> GestureDetector(child: categoriesInHomeView(modelCat,index),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetails(id: modelCat!.dataAll.dataList[index].id)));
            },), separatorBuilder: (context,index)=>const SizedBox(width: 5,), itemCount: modelCat!.dataAll.dataList.length),
      ),
      SizedBox(height: 15,),
      Text("Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      SizedBox(height: 15,),
      Container(
        color: Colors.grey[200],
        child: GridView.count(
          childAspectRatio: 1/1.3,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
        children: List.generate(modelHome.data!.products.length, (index) => GestureDetector(child: productsView(modelHome, index,fav,context),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(modelHome.data!.products[index].id)));
        },)),),
      )
    ],
  ),
);

Widget bannersView(HomeModel model) {
  List<Widget> bannersList = [];

  model.data!.banners.forEach((element) {
    bannersList.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(height: 300,width: double.infinity,child: ClipRRect(child: Image.network(element.image,fit: BoxFit.cover,width: double.infinity,),borderRadius: BorderRadius.circular(25),)),
    ));
  });
  return Container(
    width: double.infinity,
    child: CarouselSlider(
        items:bannersList,
        options: CarouselOptions(
          autoPlay: true,

        )
    ),
  );
}
Widget categoriesInHomeView(CategoriesModel? model,index){
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
    Image.network(model!.dataAll.dataList[index].image,height: 100,width: 120,),
    Container(child: Text(model.dataAll.dataList[index].name,style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),color: Colors.black38,width: 120,),
  ],);
}
Widget productsView(HomeModel? model,index, Map<int,bool> fav,context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(child: Image.network(model!.data!.products[index].image)),
            Text(model.data!.products[index].name),
            SizedBox(height: 5,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("${model.data!.products[index].price.toString()} EGP",style: TextStyle(color: Colors.purple),),
                ),
                model.data!.products[index].discount !=0 ? Text(model.data!.products[index].oldPrice.toString(),style: TextStyle(color: Colors.grey[400],decoration: TextDecoration.lineThrough),):Text(""),
                Spacer(),
                CircleAvatar(

                  backgroundColor:fav[model.data!.products[index].id]??false ?Colors.purple:Colors.grey[300],
                  child: IconButton(
                    icon:Icon(Icons.favorite_border,color: Colors.white,), onPressed: () {
                      HomeLayoutCubit.get(context).changeFavorite(id: model.data!.products[index].id);
                  },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    ),
  );
}