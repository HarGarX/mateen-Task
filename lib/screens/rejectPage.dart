import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mateen/predef/colorPalette.dart';

class RejectPage extends StatefulWidget {
  @override
  _RejectPageState createState() => _RejectPageState();
}

class _RejectPageState extends State<RejectPage> {

  File pickedImage;

  final imagePicker = ImagePicker();

  Future pickImage() async{

      final image = await imagePicker.getImage(source: ImageSource.camera);

      setState((){
      pickedImage = File(image.path);});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery ID'),
        backgroundColor: ColorPalette().defaultColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(height:10.0),
                    Text(
                      'Customer Name: ',
                      style: TextStyle(
                        letterSpacing: 1.1,
                        fontSize: 16.0
                      ),
                    ),
                    SizedBox(height:10.0),
                    Text(
                      'Address: Lorem ipsum dolor emet sit Lorem ipsum dolor emet sit',
                      style: TextStyle(
                        letterSpacing: 1.1,
                        fontSize: 16.0
                      ),
                    ),
                    SizedBox(height:10.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'UPLOAD IMAGE',
                              style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                          
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:1,
                              child: pickedImage == null ? Image.asset(
                                'assets/image.png',
                                height: 100,
                              ): Image.file(pickedImage, height: 100),
                            ),
                            
                            Expanded(flex:1, child: Text(pickedImage == null ?'No image':'new picture')),
                            Expanded(
                              flex:1,
                              child: FloatingActionButton(
                                onPressed: (){
                                  pickImage();
                                },
                                backgroundColor: ColorPalette().secondaryColor,
                                child: Icon(Icons.add, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                          
                        ]
                      ),
                      )
                    ),
                    SizedBox(height:10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'REJECTION REASON',
                                  style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Type your reason here...'
                                ),
                                maxLines: 10,
                              )
                              
                            ]
                          ),
                          )
                        ),
                        SizedBox(height:10.0),
                        FloatingActionButton.extended(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/scanHistory');
                          },
                          label: Text('Confirm Rejection'),
                          backgroundColor: ColorPalette().secondaryColor,
                        )
                      ],
                    ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}