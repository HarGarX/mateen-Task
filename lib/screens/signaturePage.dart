import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {

  SignatureController controller;

  @override
  void initState(){
    super.initState();
 
    controller = SignatureController(
      penColor: Colors.white,
      penStrokeWidth: 4,
    );
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Signature(
            controller: controller,
            backgroundColor: Colors.black,
             
          ),
          Container(
            color: ColorPalette().defaultColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 36,
                  icon:Icon(
                    Icons.check, 
                    color: Colors.white),
                  onPressed: () async {
                    if(controller.isNotEmpty){
                      final signature = await exportSignature();

                      await Navigator.of(context).pushNamed('/signatureVisualization', arguments: signature);
                    }
                  },
                ),
                IconButton(
                  iconSize: 36,
                  icon:Icon(
                    Icons.clear, 
                    color: Colors.red),
                  onPressed: ()=>controller.clear(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Uint8List> exportSignature() async {

    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: ColorPalette().defaultColor,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();

    exportController.dispose();
    return signature;
  }


}

