import 'package:blockchain/SupplierInfo.dart';
import 'package:blockchain/theme.dart';
import 'package:flutter/material.dart';

class SupplierList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SupplierList();
  }
}
List<String> suppliers = ["Sun Pharmaceuticals","Global Medicos","98.6 Medications","City Hospital Pharmacy","Jubilant Life Sciences","Mankind Pharmaceuticals"];
class _SupplierList extends State<SupplierList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/6,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: suppliers.map((e){
                    return MyTile(e,context);
                  }).toList()
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget MyTile(String text,BuildContext context)
  {
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            title: Text(text,style: normal,),
            trailing: Icon(Icons.arrow_forward),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          )
        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierInfo()));
      },
    );
  }
}
