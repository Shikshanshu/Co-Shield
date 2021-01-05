import 'package:blockchain/BlockChainTest.dart';
import 'package:blockchain/MainPage.dart';
import 'package:blockchain/QRCodeScanner.dart';
import 'package:blockchain/Supplier/Transporter.dart';
import 'package:blockchain/SupplierFeedback.dart';
import 'package:blockchain/VaccineInfo.dart';
import 'package:blockchain/VaccineVerifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'theme.dart';
import 'SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/vaccineInfo': (context)=>VaccineInfo(ModalRoute.of(context).settings.arguments)
      },
    );
  }
}
