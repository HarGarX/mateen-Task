
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mateen/screens/frame4.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  Barcode barcode;

  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController controller;

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override 
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid){
      await controller.pauseCamera();
    }

    await controller.resumeCamera();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children:[
          
          mateenQRView(context),
          Positioned(
            top: 30, 
            left: 10,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              iconSize: 40,
              icon: Icon(Icons.clear),
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom:20,
            left: 0,
            right: 0,
            child: scanResult(),
          ),
        ]
      )
    );
  }

  Widget scanResult(){
    return Text(
      barcode!=null? 'Result: ${barcode.code}' : 'Looking for a QR code...',
      maxLines:3,
    );
  }

  Widget mateenQRView(BuildContext context){
    return QRView(
      key: qrKey, 
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
        borderLength: 20,
        borderWidth: 10,
        borderRadius: 10,
        borderColor: Theme.of(context).accentColor,
      )
    );
  }

  void onQRViewCreated(QRViewController controller){
    setState(()=>this.controller = controller);

    try{
      controller.scannedDataStream.
      listen((barcode)=>setState((){
        this.barcode = barcode;
        if(barcode != null){
          //wait two seconds
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Frame4(scanned:barcode.code)));
        }
      })
    );
    } on PlatformException{
      barcode = null;
    }
  }
}