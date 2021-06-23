import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'dart:io';


class DeliverPage extends StatefulWidget {

  final Image signature;

  const DeliverPage({Key key, @required this.signature}) : super(key: key);

  @override
  _DeliverPageState createState() => _DeliverPageState(signature);
}

class _DeliverPageState extends State<DeliverPage> {

  Image signature;

  _DeliverPageState(this.signature);

  //lets init the check box value to false
  bool checkboxValue = false;

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
        children: [Padding(
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
              Text(
                'COD AMOUNT: ',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 16.0
                ),
              ),
              SizedBox(height:10.0),
              Text(
                'Currency: ',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 16.0
                ),
              ),
              SizedBox(height:10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Out of delivery area: ',
                    style: TextStyle(
                      letterSpacing: 1.1,
                      fontSize: 16.0
                    ),
                  ),
                  Checkbox(
                    value: checkboxValue,
                    onChanged: (bool value){
                      setState((){
                        checkboxValue = value;
                      });
                    },
                    activeColor: ColorPalette().defaultColor,
                  ),
                ],
              ),
              SizedBox(height:10.0),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Collected amount',
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(5.0)
                    ),
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorPalette().defaultColor,
                    )
                  ),
                )
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
                        'Proof of Delivery',
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
                            'Customer Signature',
                            style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                        signature.image == null ? GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/signaturePage');
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child:  Text('Tap here to sign')
                              ),
                            ),
                          ),
                        ) : Center(child: signature),
                      ]
                    ),
                    )
                  ),
                  SizedBox(height:10.0),
              FloatingActionButton.extended(
                onPressed: () async{
                  //show delivery confirmation dialog box
                  showDialog(
                    context: context, 
                    barrierDismissible: true, 
                    builder: (context){
                    return AlertDialog(
                      title: Text('Attention'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Text('Collected amount is not Equal to COD amount.'),
                          Text('Are you sure you want to continue?'),
                        ]
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                              color: ColorPalette().defaultColor,
                            ),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            'EDIT',
                            style: TextStyle(
                              color: ColorPalette().defaultColor,
                            ),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
                );
                  //showDeliveryConfirmation();
                },
                label: Text('Confirm Delivery'),
                backgroundColor: ColorPalette().secondaryColor,
              )
                ],
              ),
            ]
          ),
        ),]
      ),
    );
  }
}