import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:permission_handler/permission_handler.dart';

class SignatureVisualization extends StatelessWidget {

  final Uint8List signature;

  const SignatureVisualization({Key key, @required this.signature}) : super(key: key); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.clear, 
              color: Colors.red
            ),
            onPressed: ()=>cancelStoring(context),
          ),
        title: Text('Save signature?'),
        centerTitle: true,
        backgroundColor: ColorPalette().defaultColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.check, 
              color: Colors.white
            ),
            onPressed: ()=>storeSignature(context),
          )
        ],
      ),
      body: Center(
        child: Image.memory(signature),
      ),
    );
  }


  void cancelStoring(BuildContext context){

    Navigator.of(context).pushReplacementNamed('/deliveryPage', arguments: Image.memory(signature));

  }


  Future storeSignature(BuildContext context) async{

    final status = await Permission.storage.status;
    if(!status.isGranted){
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time.png';

    final result = await ImageGallerySaver.saveImage(signature, name: name, );
    final isSuccessful = result['isSuccess'];

    if(isSuccessful){
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Saved'),
      ));
      Navigator.of(context).pushReplacementNamed('/deliveryPage', arguments: Image.memory(signature));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to save to file'),
      ));
    }
  }
}