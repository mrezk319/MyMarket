import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:Shop/modules/logIn/log_in.dart';
import 'package:Shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class PageViewData {
  PageViewData(
      {required this.image, required this.title, required this.statement});

  late String image, title, statement;
}
class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var pageVIewController = PageController();
  int pageIndex = 0;
  List<PageViewData> PageViewItems = [
    PageViewData(
        image: "assets/images/firstImage.jpg",
        title: "Faster App Shopping",
        statement: "Every product you want will be with you faster"),
    PageViewData(
        image: "assets/images/secondImage.jpg",
        title: "Faster App Shopping",
        statement: "Every product you want will be with you faster"),
    PageViewData(
        image: "assets/images/thirdImage.jpg",
        title: "Faster App Shopping",
        statement: "Every product you want will be with you faster"),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,actions: [TextButton(child: Text("Skip",style:TextStyle(color: Colors.purple,fontSize: 17)),onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
        CacheHelper.saveData('onBoarding', true);
      },)],),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 450,
            child: PageView.builder(
              controller: pageVIewController,
              itemBuilder: (context, index) => pageViewItem(PageViewItems, index),
              itemCount: PageViewItems.length,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index){
                setState(() {
                  pageIndex = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              children: [
                SmoothPageIndicator(controller: pageVIewController, count: PageViewItems.length,effect: JumpingDotEffect(activeDotColor: Colors.purple),),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(pageIndex != PageViewItems.length-1)
                  pageVIewController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.ease,);
                  else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                    CacheHelper.saveData('onBoarding', true);
                  }
                },child: Icon(Icons.arrow_forward_ios,size: 27,),backgroundColor: Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget pageViewItem(List<PageViewData> PageViewItems, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              PageViewItems[index].image,
              width: 300,
              height: 300,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              PageViewItems[index].title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              PageViewItems[index].statement,
              style: TextStyle(fontSize: 20, color: Colors.black26),
            ),
          ],
        ),
      ),
    );
