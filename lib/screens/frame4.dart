
import 'package:flutter/material.dart';
import 'package:mateen/models/httpService.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:mateen/widgets/mateenDatePicker.dart';
import 'package:mateen/widgets/scannedItemInfo.dart';

class Frame4 extends StatelessWidget {
  final String scanned;

  const Frame4({Key key, @required this.scanned}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Stack(
          children:[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ScannedItemInfo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/rejectPage');
                        },
                        child: Text(
                          'REJECT',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: ColorPalette().defaultColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {

                          showDialog(
                            barrierDismissible: true,
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                title: Text('DELETE'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                   // GAFAR : REMOVE THE ALERT DIALOG VIEW
                                  ]
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'DELETE',
                                      style: TextStyle(
                                        color: Color.fromARGB(255,86, 0, 232),
                                      ),
                                    ),
                                    onPressed: (){
                                      HttpFetchShipmentService().removeShipment('Test10').then((value) {
                                       var count = 0;
                                        Navigator.popUntil(context, (route) {
                                          return count++ == 3;
                                        });


                                      }); //GAFAR: REMOVE SHIPMENT BY shipmentReference & UPDATE LOCAL DATA & POP TO ROOT PAGE
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'CANCEL',
                                      style: TextStyle(
                                        color: Color.fromARGB(255,86, 0, 232),
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
                        },
                        child: Text(
                          'DELETE', // GAFAR : UPDATE THE VIEW FROM RESCHEDULE TO DELETE
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: ColorPalette().defaultColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          try {
                            Navigator.of(context).pushNamed('/deliveryPage',arguments: Image(image: null,));
                          } catch (e) {
                            print(e); 
                          }
                          
                        },
                        child: Text(
                          'DELIVER',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: ColorPalette().defaultColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30, 
              left: 10,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/scanHistory');
                },
                iconSize: 40,
                icon: Icon(Icons.clear),
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 20,
              child: Text('scanned qr info: $scanned'),
            )
          ]
        ),
      )
    );
  }
}