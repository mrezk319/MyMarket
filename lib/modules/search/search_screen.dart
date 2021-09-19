import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_2/layout/cubit/home_layout_cubit.dart';
import 'package:shop_app_2/layout/cubit/home_layout_states.dart';
import 'package:shop_app_2/models/searchModel.dart';
import 'package:shop_app_2/modules/productDetails/product_details.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.purple
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Search",
                  ),
                  onChanged: (val) {
                    HomeLayoutCubit.get(context).getSearchProduct(txt: val);
                  },
                ),
                if (state is LoadingSearch)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 10),
                    child: LinearProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  ),
                HomeLayoutCubit.get(context).searchModel == null? Text("") :
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  children: List.generate(
                      HomeLayoutCubit.get(context).searchModel!.data.data.length,
                          (index) => productsSearchView(
                              HomeLayoutCubit.get(context)
                                  .searchModel,
                          index,
                          HomeLayoutCubit.get(context).isFavorite,
                          context,)
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context, state) {
        },
      ),
    );
  }
}
Widget productsSearchView(SearchModel? model, index, Map<int, bool> fav, context) {
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(
          model!.data.data[index].id
      )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              GestureDetector(child: Image.network(model!.data.data[index].image,height: 250,),),
              Text(model.data.data[index].name),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${model.data.data[index].price.toString()} EGP",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}