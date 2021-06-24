import 'package:blockchain/Supplier/MainPage.dart';
import 'package:blockchain/VaccineInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //Barcode barcode = new Barcode("567894536836",BarcodeFormat.codabar, []);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/vaccineInfo': (context)=>VaccineInfo(ModalRoute.of(context).settings.arguments),
        '/mainPage': (context)=>MainPage()
      },
    );
  }
}
