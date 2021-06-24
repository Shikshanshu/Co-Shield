import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'MainPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => new IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
  List data = new List();
  List<Widget> tabs = new List();
  int selectedIndex=0;
  CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    data.add({
      'title': "Yes to vaccine, Yes to caution",
      'path': 'Assets/intro1.png',
      'image': null,
      'description': "The vaccines are upto 91.6% effective, those are the odds to return to your normal life"
    });
    data.add({
      'title': "Redefine HealthCare",
      'path': 'Assets/intro2.png',
      'image': 'Assets/intro3.png',
      'description': "We redefined healthcare using latest technologies to help users with live vaccine data, customer reviews, and performance report on vaccine suppliers and more"
    });
    super.initState();
  }
  void CallbackCarousel(int index,CarouselPageChangedReason reason){
    setState(() {
      selectedIndex = index;
    });
  }
  void renderListCustomTabs() {
    for (int i = 0; i < data.length; i++) {
      var currentSlide = data[i];
      tabs.add(Container(
        child: Center(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Text(
                        currentSlide['title'],
                        style: heading1,
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.all(20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (currentSlide['image']==null)?Container():Center(
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(currentSlide['image']),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      currentSlide['description'],
                      style: normal1,
                      textAlign: TextAlign.center,
                    ),
                    margin: EdgeInsets.all(20.0),
                  ),
                ],
              )
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    tabs.clear();
    renderListCustomTabs();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(data[selectedIndex]['path']),
                    fit: BoxFit.fill
                )
            ),
          ),
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: MediaQuery.of(context).size.height,
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: CallbackCarousel,
            ),
            items: tabs,
          ),
          (selectedIndex!=data.length-1)?Positioned(
            top: 50,
            right: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                child: Text("SKIP",style: subheading1,),
                color: Colors.deepPurpleAccent,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ):Positioned(
            top: 50,
            right: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                child: Text("DONE",style: subheading1,),
                color: Colors.deepPurpleAccent,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}