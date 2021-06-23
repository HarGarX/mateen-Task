import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:mateen/screens/barcodeScanPage.dart';
import 'package:mateen/screens/deliverPage.dart';
import 'package:mateen/screens/frame4.dart';
import 'package:mateen/screens/loginScreen.dart';
import 'package:mateen/screens/rejectPage.dart';
import 'package:mateen/screens/scanPage.dart';
import 'package:mateen/screens/scannedHistory.dart';
import 'package:mateen/screens/signaturePage.dart';
import 'package:mateen/screens/signatureVisualization.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      
      case '/deliveryPage':
        if(args is Image){
          return MaterialPageRoute(builder: (_) => DeliverPage( signature: args));
        }
        return _errorPage();

      case '/scannedItemPage':
        if(args is String){
          return MaterialPageRoute(builder: (_)=>Frame4(
            scanned: args,
          ));
        }

        return _errorPage();


      case '/rejectPage':
        return MaterialPageRoute(builder: (_) => RejectPage());

      case '/scanPage':
        return MaterialPageRoute(builder: (_) => ScanPage());

      case '/barCodeScanPage':
        return MaterialPageRoute(builder: (_) => BarCodeScanPage());

      case '/scanHistory':
        return MaterialPageRoute(builder: (_) => ScannedHistory());

      case '/signaturePage':
        return MaterialPageRoute(builder: (_) => SignaturePage());

      case '/signatureVisualization':
        if(args is Uint8List){
          return MaterialPageRoute(builder: (_) => SignatureVisualization(signature: args));
        }
        return _errorPage();

      default:
        return _errorPage();

    }

  }

  static Route<dynamic> _errorPage(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          centerTitle: true,
          backgroundColor: ColorPalette().defaultColor,
        ),
        body: Center(
          child: Text('Error getting this page...'),
        ),
      );
    });
  }

}