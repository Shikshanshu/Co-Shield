import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../oval_right_clipper.dart';
import '../theme.dart';



Widget _buildRow(BuildContext context,IconData icon,int index,bool data,ValueChanged onClick){

  return GestureDetector(
    onTap: (){
      if(index==0)
        onClick(true);
      else if(index==1)
        onClick(true);
      else if(index==2)
        onClick(true);
      else
        Fluttertoast.showToast(msg: "Feature Available Soon",backgroundColor: Colors.green);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(children: [
        Icon(
          icon,
          color: (!data)?primaryBlue:secondaryGreen,
          size: 30,
        ),
      ]),
    ),
  );
}
buildDrawer(context,selectedIndex,ValueChanged onChange){
  return Scaffold(
    body: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 40,top: 5,bottom: 5),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    _buildRow(context, Icons.account_circle_rounded,0,(selectedIndex==0),(data){
                      if(data==true)
                        onChange(0);
                    }),
                    _buildRow(context,Icons.verified,1,(selectedIndex==1),(data){
                      if(data==true)
                        onChange(1);
                    }),
                    _buildRow(context,Icons.agriculture_rounded,2,(selectedIndex==2),(data){
                      if(data==true)
                        onChange(2);
                    }),
                    _buildRow(context,Icons.share,3,(selectedIndex==3),(data){
                    }),
                    _buildRow(context,Icons.star,4,(selectedIndex==4),(data){
                    }),
                    _buildRow(context,Icons.info_outline,5,(selectedIndex==5),(data){
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}