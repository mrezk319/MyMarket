import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_states.dart';
import 'package:shop_app_2/modules/getCarts/GetCarts.dart';
import 'package:shop_app_2/modules/logIn/log_in.dart';
import 'package:shop_app_2/modules/search/search_screen.dart';
import 'package:shop_app_2/shared/network/local/cache_helper.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return BlocProvider(
        create: (BuildContext context)=>HomeLayoutCubit()..getHomeData()..getCategories()..getFavorite()..getProfile(),
      child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        builder: (context,state)=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Rezk-Shop",style: TextStyle(color: Colors.black,fontSize: 20),),
            actions: [
              IconButton(icon: Icon(Icons.search,color: Colors.deepPurple,),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
              },),
            ],
          ),
          body: HomeLayoutCubit.get(context).Screens[HomeLayoutCubit.get(context).indexBottomNavBar],
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCarts()));
          },child: Icon(Icons.shopping_cart),backgroundColor: Colors.purple,),
          floatingActionButtonLocation :FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: [
              Icons.home,
              Icons.category,
              Icons.favorite_border,
              Icons.settings,
            ],
            activeIndex: HomeLayoutCubit.get(context).indexBottomNavBar,
            onTap: (x){
            HomeLayoutCubit.get(context).changeIndexBottom(x);
          },
            activeColor: Colors.purpleAccent,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
          ),
        ),
        listener: (context,state){
        },
      ),

    );
  }
}