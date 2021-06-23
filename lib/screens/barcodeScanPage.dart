import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mateen/predef/colorPalette.dart';

class BarCodeScanPage extends StatefulWidget {
  @override
  _BarCodeScanPageState createState() => _BarCodeScanPageState();
}

class _BarCodeScanPageState extends State<BarCodeScanPage> {
  
  String barcode;

  @override
  void initState() {

    startScan();
    super.initState();


  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Bar code Scanned'),
        backgroundColor: ColorPalette().defaultColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Scan Result',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height:20),
            Text(barcode==null?'Scanning...':'$barcode',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height:20),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/scannedItemPage', arguments: barcode);
              },
              color: ColorPalette().secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Proceed',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Future<void> startScan() async{

    try{
      final barcode = await FlutterBarcodeScanner.scanBarcode(
      '#6200EE',
      "cancel",
      true,
      ScanMode.BARCODE
    );

    if (!mounted) return;

    setState(
      (){
        this.barcode = barcode;
      }
    );
    } on PlatformException{
      barcode = "We can't get the platform version";
    }
  }


}